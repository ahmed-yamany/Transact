import Combine
import Foundation

public protocol HTTPClient {
    typealias Response = (Data, HTTPURLResponse)
    typealias Result = Swift.Result<Response, Error>
    typealias PublisherResult = AnyPublisher<Response, Error>

    @discardableResult func perform(urlRequest: @escaping () -> URLRequest, completion: @escaping (HTTPClient.Result) -> Void) -> URLSessionTask
    @discardableResult func perform(endpoint: @escaping () -> HTTPEndPoint, completion: @escaping (HTTPClient.Result) -> Void) -> URLSessionTask

    func perform(urlRequest: @escaping () -> URLRequest) async throws -> Response
    func perform(endpoint: @escaping () -> HTTPEndPoint) async throws -> Response

    func perform(urlRequest: @escaping () -> URLRequest) -> HTTPClient.PublisherResult
    func perform(endpoint: @escaping () -> HTTPEndPoint) -> HTTPClient.PublisherResult
}
