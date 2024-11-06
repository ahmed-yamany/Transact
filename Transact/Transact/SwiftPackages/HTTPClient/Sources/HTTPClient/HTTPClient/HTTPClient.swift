import Combine
import Foundation

public protocol HTTPClient {
    typealias Response = (Data, HTTPURLResponse)
    typealias Result = Swift.Result<Response, Error>
    typealias PublisherResult = AnyPublisher<Response, Error>

    @discardableResult
    func perform(urlRequest: URLRequest, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask
    @discardableResult
    func perform(endpoint: HTTPEndPoint, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask
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

    func perform(urlRequest: URLRequest) async throws -> Response {
        return try await withCheckedThrowingContinuation { continuation in
            perform(urlRequest: urlRequest, completion: { result in
                switch result {
                case let .success(response):
                    continuation.resume(returning: response)
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            })
        }
    }

    func perform(endpoint: HTTPEndPoint) async throws -> Response {
        return try await withCheckedThrowingContinuation { continuation in
            perform(endpoint: endpoint, completion: { result in
                switch result {
                case let .success(response):
                    continuation.resume(returning: response)
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            })
        }
    }
}
