import Combine
import Foundation
import HTTPClient

public struct URLSessionHTTPClient: HTTPClient {
    public struct InvalidHTTPResponseError: Error {}
    
    private let session: URLSession
    private let enableLogger: Bool
    
    public init(session: URLSession = URLSession.shared, enableLogger: Bool = true) {
        self.session = session
        self.enableLogger = enableLogger
    }
    
    @discardableResult
    public func perform(urlRequest: URLRequest, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        let task = session.dataTask(with: urlRequest) { data, response, error in
            let result = createResult(from: data, response: response, error: error)
            
            if enableLogger {
                logRequest(urlRequest: urlRequest, result: result)
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
    
    private func createResult(from data: Data?, response: URLResponse?, error: Error?) -> HTTPClient.Result {
        Result {
            if let error {
                throw error
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                throw InvalidHTTPResponseError()
            }
            return (data, response)
        }
    }
    
    private func logRequest(urlRequest: URLRequest, result: HTTPClient.Result) {
        switch result {
            case .success(let success):
                NetworkLogger.log(urlRequest: urlRequest, response: success.1, dataResponse: success.0, error: nil)
            case .failure(let error):
                NetworkLogger.log(urlRequest: urlRequest, response: nil, dataResponse: nil, error: error)
        }
    }
}
