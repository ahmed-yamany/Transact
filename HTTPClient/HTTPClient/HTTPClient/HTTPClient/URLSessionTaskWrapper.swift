import Foundation

public struct URLSessionTaskWrapper: HTTPClientTask {
    let wrapped: URLSessionTask

    public func cancel() {
        wrapped.cancel()
    }
}
