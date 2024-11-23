import Combine
import Foundation
import HTTPClient

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
    public func perform(urlRequest: URLRequest, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        let task = session.dataTask(with: urlRequest) { data, response, error in
            let result = Result {
                try validate(request: urlRequest, response: response, data: data, error: error)
            }
            completion(result)
        }

        task.resume()
        return URLSessionHTTPClientTaskWrapper(wrapped: task)
    }

    @discardableResult
    public func perform(endpoint: HTTPEndPoint, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        perform(urlRequest: URLRequest(endpoint: endpoint), completion: completion)
    }

    public func perform(urlRequest: URLRequest) async throws -> HTTPClient.Response {
        let (data, response): (Data?, URLResponse) = try await session.data(for: urlRequest)
        return try validate(request: urlRequest, response: response, data: data, error: nil)
    }

    public func perform(endpoint: HTTPEndPoint) async throws -> HTTPClient.Response {
        try await perform(urlRequest: URLRequest(endpoint: endpoint))
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

public extension HTTPClient {
    func perform(urlRequest: URLRequest) -> HTTPClient.PublisherResult {
        Future { promise in
            perform(urlRequest: urlRequest) { result in
                switch result {
                case let .success(response):
                    promise(.success(response))
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    func perform(endpoint: HTTPEndPoint) -> HTTPClient.PublisherResult {
        Future { promise in
            perform(endpoint: endpoint) { result in
                switch result {
                case let .success(response):
                    promise(.success(response))
                case let .failure(error):
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
