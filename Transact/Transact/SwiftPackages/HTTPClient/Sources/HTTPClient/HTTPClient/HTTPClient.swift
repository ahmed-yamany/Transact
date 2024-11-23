import Combine
import Foundation

public protocol HTTPClient {
    typealias Response = (Data, HTTPURLResponse)
    typealias Result = Swift.Result<Response, Error>
    typealias PublisherResult = AnyPublisher<Response, Error>

    @discardableResult func perform(urlRequest: URLRequest, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask
    @discardableResult func perform(endpoint: HTTPEndPoint, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask

    func perform(urlRequest: URLRequest) async throws -> Response
    func perform(endpoint: HTTPEndPoint) async throws -> Response
}
