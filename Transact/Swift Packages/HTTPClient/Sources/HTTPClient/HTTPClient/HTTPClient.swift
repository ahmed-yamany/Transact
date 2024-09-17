import Combine
import Foundation

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    typealias PublisherResult = AnyPublisher<(Data, HTTPURLResponse), Error>

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
    
    func perform(urlRequest: URLRequest) async throws -> HTTPClient.Result {
        return try await withCheckedThrowingContinuation { continuation in
            perform(urlRequest: urlRequest, completion: continuation.resume(returning:))
        }
    }

    func perform(endpoint: HTTPEndPoint) async throws -> HTTPClient.Result {
        return try await withCheckedThrowingContinuation { continuation in
            perform(endpoint: endpoint, completion: continuation.resume(returning:))
        }
    }
}
