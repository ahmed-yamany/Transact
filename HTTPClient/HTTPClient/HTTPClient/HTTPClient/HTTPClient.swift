import Combine
import Foundation

public protocol HTTPClient {
    typealias Result = Swift.Result<HTTPClientResponse, Error>

    @discardableResult func perform(urlRequest: @escaping () -> URLRequest, completion: @escaping (Self.Result) -> Void) -> HTTPClientTask
    @discardableResult func perform(endpoint: @escaping () -> HTTPEndPoint, completion: @escaping (Self.Result) -> Void) -> HTTPClientTask
}

public struct HTTPClientResponse {
    public let data: Data
    public let response: HTTPURLResponse

    public init(data: Data, response: HTTPURLResponse) {
        self.data = data
        self.response = response
    }
}
