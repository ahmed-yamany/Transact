//
//  MockHTTPSession.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 23/12/2024.
//
import Foundation
@testable import HTTPClient

class MockHTTPSession: HTTPSession {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?

    init(mockData: Data? = nil, mockResponse: URLResponse? = nil, mockError: Error? = nil) {
        self.mockData = mockData
        self.mockResponse = mockResponse
        self.mockError = mockError
    }

    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        MockURLSessionDataTask {
            completionHandler(self.mockData, self.mockResponse, self.mockError)
        }
    }

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        if let mockError {
            throw mockError
        }
        
        if let mockData, let mockResponse {
            return (mockData, mockResponse)
        }
        
        throw InvalidHTTPResponseError()
    }
    
 }

class MockURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
}
