import Combine
import Foundation

public protocol HTTPClient {
    typealias Response = (Data, HTTPURLResponse)
    typealias Result = Swift.Result<Response, Error>
    typealias PublisherResult = AnyPublisher<Response, Error>

    @discardableResult func perform(urlRequest: @escaping () -> URLRequest, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask
    @discardableResult func perform(endpoint: @escaping () -> HTTPEndPoint, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask

    func perform(endpoint: @escaping () -> HTTPEndPoint) async throws -> Response
}
