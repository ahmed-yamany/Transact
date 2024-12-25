//
//  URLSessionHTTPClient.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 05/12/2024.
//
import Combine
import Foundation

public struct URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    private let logger: NetworkLoggerProtocol?

    public init(session: URLSession = URLSession.shared, logger: NetworkLoggerProtocol? = NetworkLogger()) {
        self.session = session
        self.logger = logger
    }

    @discardableResult
    public func perform(urlRequest: @escaping () -> URLRequest, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        let urlRequest = urlRequest()
        let task = session.dataTask(with: urlRequest) { data, response, error in
            let result = Result {
                try validate(request: urlRequest, response: response, data: data, error: error)
            }
            completion(result)
        }

        task.resume()
        return URLSessionTaskWrapper(wrapped: task)
    }

    @discardableResult
    public func perform(endpoint: @escaping () -> HTTPEndPoint, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        perform(urlRequest: { URLRequest(endpoint: endpoint()) }, completion: completion)
    }
}

private extension URLSessionHTTPClient {
    private func validate(request: URLRequest, response: URLResponse?, data: Data?, error: Error?) throws -> HTTPClientResponse {
        if let error {
            if let logger {
                logger.log(urlRequest: request, response: nil, dataResponse: nil, error: error)
            }

            throw error
        }

        guard let data else {
            throw InvalidDataResponse()
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            throw InvalidHTTPResponseError()
        }

        if let logger {
            logger.log(urlRequest: request, response: httpResponse, dataResponse: data, error: nil)
        }

        return HTTPClientResponse(data: data, response: httpResponse)
    }
}
