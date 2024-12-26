//
//  URLSessionHTTPClient.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 05/12/2024.
//
import Combine
import Foundation

public struct URLSessionHTTPClient: HTTPClient {
    private let session: HTTPSession
    private let logger: NetworkLoggerProtocol?

    public init(session: HTTPSession = URLSession.shared, logger: NetworkLoggerProtocol? = NetworkLogger()) {
        self.session = session
        self.logger = logger
    }

    @discardableResult
    public func perform(urlRequest: @escaping () -> URLRequest, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        let urlRequest = urlRequest()
        let task = session.dataTask(with: urlRequest) { data, response, error in
            let result = HTTPClient.Result(catching: {
                try validate(request: urlRequest, response: response, data: data, error: error)
            })
            completion(result)
        }

        task.resume()
        return URLSessionTaskWrapper(wrapped: task)
    }

    public func perform(urlRequest: @escaping () async -> URLRequest) async throws -> HTTPClientResponse {
        let urlRequest = await urlRequest()
        do {
            let (data, response): (Data?, URLResponse) = try await session.data(for: urlRequest)
            return try validate(request: urlRequest, response: response, data: data, error: nil)
        } catch {
            return try validate(request: urlRequest, response: nil, data: nil, error: error)
        }
    }
}

private extension URLSessionHTTPClient {
    private func validate(request: URLRequest, response: URLResponse?, data: Data?, error: Error?) throws -> HTTPClientResponse {
        if let error {
            if let logger {
                logger.log(urlRequest: request, response: nil, dataResponse: nil, error: error)
            }

            throw error
        }

        guard let data else {
            throw InvalidDataResponse()
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw InvalidHTTPResponseError()
        }

        if let logger {
            logger.log(urlRequest: request, response: httpResponse, dataResponse: data, error: nil)
        }

        return HTTPClientResponse(data: data, response: httpResponse)
    }
}
