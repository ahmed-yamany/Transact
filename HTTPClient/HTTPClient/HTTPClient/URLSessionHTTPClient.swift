//
//  URLSessionHTTPClient.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 05/12/2024.
//
import Combine
import Foundation

public struct URLSessionHTTPClient: HTTPClient {
    public struct InvalidHTTPResponseError: Error {}
    public struct InvalidData: Error {}

    private let session: URLSession
    private let enableLogger: Bool

    public init(session: URLSession = URLSession.shared, enableLogger: Bool = true) {
        self.session = session
        self.enableLogger = enableLogger
    }

    @discardableResult
    public func perform(urlRequest: @escaping () -> URLRequest, completion: @escaping (HTTPClient.Result) -> Void) -> URLSessionTask {
        let urlRequest = urlRequest()
        let task = session.dataTask(with: urlRequest) { data, response, error in
            let result = Result {
                try validate(request: urlRequest, response: response, data: data, error: error)
            }
            completion(result)
        }

        task.resume()
        return task
    }

    @discardableResult
    public func perform(endpoint: @escaping () -> HTTPEndPoint, completion: @escaping (HTTPClient.Result) -> Void) -> URLSessionTask {
        perform(urlRequest: { URLRequest(endpoint: endpoint()) }, completion: completion)
    }

    public func perform(urlRequest: @escaping () -> URLRequest) async throws -> HTTPClient.Response {
        let urlRequest = urlRequest()
        let (data, response): (Data?, URLResponse) = try await session.data(for: urlRequest)
        return try validate(request: urlRequest, response: response, data: data, error: nil)
    }

    public func perform(endpoint: @escaping () -> HTTPEndPoint) async throws -> HTTPClient.Response {
        try await perform(urlRequest: { URLRequest(endpoint: endpoint()) })
    }

    public func perform(urlRequest: @escaping () -> URLRequest) -> HTTPClient.PublisherResult {
        var task: URLSessionTask?
        return Future { promise in
            task = perform(urlRequest: urlRequest) { result in
                switch result {
                case let .success(response):
                    promise(.success(response))
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }.handleEvents(receiveCancel: {
            task?.cancel()
        }).eraseToAnyPublisher()
    }

    public func perform(endpoint: @escaping () -> HTTPEndPoint) -> HTTPClient.PublisherResult {
        perform(urlRequest: { URLRequest(endpoint: endpoint()) })
    }
}

private extension URLSessionHTTPClient {
    private func validate(request: URLRequest, response: URLResponse?, data: Data?, error: Error?) throws -> HTTPClient.Response {
        if let error {
            if enableLogger {
                NetworkLogger.log(urlRequest: request, response: nil, dataResponse: nil, error: error)
            }
            throw error
        }

        guard let data else {
            throw InvalidData()
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw InvalidHTTPResponseError()
        }

        if enableLogger {
            NetworkLogger.log(urlRequest: request, response: httpResponse, dataResponse: data, error: nil)
        }

        return (data, httpResponse)
    }
}
