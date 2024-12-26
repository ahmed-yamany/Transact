import Combine
import Foundation

public protocol HTTPClient {
    typealias Result = Swift.Result<HTTPClientResponse, Error>

    @discardableResult
    func perform(urlRequest: @escaping () -> URLRequest, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask
    func perform(urlRequest: @escaping () async -> URLRequest) async throws -> HTTPClientResponse
}

public extension HTTPClient {
    @discardableResult
    func perform(endpoint: @escaping () -> HTTPEndPoint, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        perform(urlRequest: { URLRequest(endpoint: endpoint()) }, completion: completion)
    }
}

public extension HTTPClient {
    func perform(endpoint: @escaping () async -> HTTPEndPoint) async throws -> HTTPClientResponse {
        try await perform(urlRequest: { await URLRequest(endpoint: endpoint()) })
    }
}
