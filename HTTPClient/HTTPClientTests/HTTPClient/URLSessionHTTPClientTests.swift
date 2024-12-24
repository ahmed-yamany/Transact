//
//  URLSessionHTTPClientTests.swift
//  HTTPClientTests
//
//  Created by Ahmed Yamany on 23/12/2024.
//

import Foundation
@testable import HTTPClient
import Testing
import XCTest

class MockURLProtocol: URLProtocol {
    static var subResponseData: Data?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        client?.urlProtocol(self, didLoad: MockURLProtocol.subResponseData ?? Data())
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}


@Suite("URLSessionHTTPClient")
struct URLSessionHTTPClientTests {
    
    func makeSut(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) -> HTTPClient {
        let mockSession = MockURLSession(mockData: data, mockResponse: response, mockError: error)
        return URLSessionHTTPClient(session: mockSession, enableLogger: false)
    }
    
    @Test("Performs request and returns a valid response")
    func performsRequestAndReturnsValidResponse() async {
        let expectedData = Data("Response data".utf8)
        let expectedResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
   
        let client = makeSut(data: expectedData, response: expectedResponse)
        
        var result: HTTPClient.Result?

        _ = await confirmation("…") { soldFood in
            client.perform(urlRequest: {
                URLRequest(url: URL(string: "https://example.com")!)
            }) { responseResult in
                result = responseResult
                soldFood()
            }
        }

        switch result {
        case let .success(response):
            #expect(response.data == expectedData, "Response data should match expected data")
            #expect(response.response == expectedResponse, "Response should match expected HTTPURLResponse")
        default:
            Issue.record("Expected a successful response, but got \(String(describing: result))")
        }
    }

    @Test("Handles network error gracefully")
    func handlesNetworkErrorGracefully() async {
        // Arrange
        let mockSession = MockURLSession()
        mockSession.mockError = NSError(domain: "TestError", code: -1)

        let client = URLSessionHTTPClient(session: mockSession, enableLogger: false)
        var result: HTTPClient.Result?

        _ = await confirmation("…") { soldFood in

            // Act
            client.perform(urlRequest: {
                URLRequest(url: URL(string: "https://example.com")!)
            }) { responseResult in
                result = responseResult
                soldFood()
            }
        }

        switch result {
        case let .failure(error):
            #expect(error.localizedDescription == "The operation couldn’t be completed. (TestError error -1.)", "Error should match the mock error")
        default:
            Issue.record("Expected an error, but got \(String(describing: result))")
        }
    }

//    @Test("Throws InvalidDataResponse for nil data")
//    func throwsInvalidDataResponseForNilData() {
//        // Arrange
//        let mockSession = MockURLSession()
//        mockSession.mockResponse = HTTPURLResponse(
//            url: URL(string: "https://example.com")!,
//            statusCode: 200,
//            httpVersion: nil,
//            headerFields: nil
//        )
//
//        let client = URLSessionHTTPClient(session: mockSession, enableLogger: false)
//        let expectation = XCTestExpectation(description: "Completion handler called")
//        var result: HTTPClient.Result?
//
//        // Act
//        client.perform(urlRequest: {
//            URLRequest(url: URL(string: "https://example.com")!)
//        }) { responseResult in
//            result = responseResult
//            expectation.fulfill()
//        }
//
//        // Assert
//        wait(for: [expectation])
//        switch result {
//        case .failure(let error):
//            #expect(error is InvalidDataResponse, "Error should be InvalidDataResponse")
//        default:
//            Issue.record("Expected InvalidDataResponse error, but got \(String(describing: result))")
//        }
//    }
//
//    @Test("Throws InvalidHTTPResponseError for invalid response")
//    func throwsInvalidHTTPResponseErrorForInvalidResponse() {
//        // Arrange
//        let mockSession = MockURLSession()
//        mockSession.mockData = Data()
//        mockSession.mockResponse = URLResponse()
//
//        let client = URLSessionHTTPClient(session: mockSession, enableLogger: false)
//        let expectation = XCTestExpectation(description: "Completion handler called")
//        var result: HTTPClient.Result?
//
//        // Act
//        client.perform(urlRequest: {
//            URLRequest(url: URL(string: "https://example.com")!)
//        }) { responseResult in
//            result = responseResult
//            expectation.fulfill()
//        }
//
//        // Assert
//        wait(for: [expectation])
//        switch result {
//        case .failure(let error):
//            #expect(error is InvalidHTTPResponseError, "Error should be InvalidHTTPResponseError")
//        default:
//            Issue.record("Expected InvalidHTTPResponseError, but got \(String(describing: result))")
//        }
//    }
}
