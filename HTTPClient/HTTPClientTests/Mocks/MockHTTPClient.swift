//
//  MockHTTPClient.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 26/12/2024.
//

import Foundation
@testable import HTTPClient

class MockHTTPClient: HTTPClient {
    
    var result: HTTPClient.Result?
    var task: HTTPClientTask?

    func perform(urlRequest: @escaping () -> URLRequest, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        DispatchQueue.global().async {
            if let result = self.result {
                completion(result)
            }
        }
        return task ?? MockHTTPClientTask()
    }
    
    func perform(urlRequest: @escaping () async -> URLRequest) async throws -> HTTPClientResponse {
        .init(data: Data(), response: HTTPURLResponse())
    }
}
