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

@Suite("URLSessionHTTPClient")
struct URLSessionHTTPClientTests {
    func makeSut(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil, logger: NetworkLoggerProtocol? = nil) -> HTTPClient {
        let mockSession = MockURLSession(mockData: data, mockResponse: response, mockError: error)
        return URLSessionHTTPClient(session: mockSession, logger: logger)
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

        _ = await confirmation("…") { confirmation in
            client.perform(urlRequest: { URLRequest(url: URL(string: "https://example.com")!) }) { responseResult in
                result = responseResult
                confirmation()
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
        let client = makeSut(error: NSError(domain: "TestError", code: -1))
        var result: HTTPClient.Result?

        _ = await confirmation("…") { confirmation in
            client.perform(urlRequest: { URLRequest(url: URL(string: "https://example.com")!) }) { responseResult in
                result = responseResult
                confirmation()
            }
        }

        switch result {
        case let .failure(error):
            #expect(error.localizedDescription == "The operation couldn’t be completed. (TestError error -1.)", "Error should match the mock error")
        default:
            Issue.record("Expected an error, but got \(String(describing: result))")
        }
    }

    @Test("Throws InvalidDataResponse for nil data")
    func throwsInvalidDataResponseForNilData() async {
        let client = makeSut(response: HTTPURLResponse())
        var result: HTTPClient.Result?

        _ = await confirmation("…") { confirmation in
            client.perform(urlRequest: { URLRequest(url: URL(string: "https://example.com")!) }) { responseResult in
                result = responseResult
                confirmation()
            }
        }

        switch result {
        case let .failure(error):
            #expect(error is InvalidDataResponse, "Error should be InvalidDataResponse")
        default:
            Issue.record("Expected InvalidDataResponse error, but got \(String(describing: result))")
        }
    }

    @Test("Throws InvalidHTTPResponseError for invalid response")
    func throwsInvalidHTTPResponseErrorForInvalidResponse() async {
        let client = makeSut(data: Data(), response: URLResponse())
        var result: HTTPClient.Result?

        _ = await confirmation("…") { confirmation in
            client.perform(urlRequest: { URLRequest(url: URL(string: "https://example.com")!) }) { responseResult in
                result = responseResult
                confirmation()
            }
        }

        switch result {
        case let .failure(error):
            #expect(error is InvalidHTTPResponseError, "Error should be InvalidHTTPResponseError")
        default:
            Issue.record("Expected InvalidHTTPResponseError, but got \(String(describing: result))")
        }
    }

    @Test("Logs error")
    func logsErrorWhenInjectingLoggerToClient() async {
        let mockLogger = MockNetworkLogger()

        let client = makeSut(error: NSError(domain: "TestError", code: -1), logger: mockLogger)

        _ = await confirmation("…") { confirmation in
            client.perform(urlRequest: { URLRequest(url: URL(string: "https://example.com")!) }) { _ in
                confirmation()
            }
        }

        #expect(mockLogger.loggedRequests.count == 1, "Logger should be called once")
        #expect(mockLogger.loggedRequests.first?.error is NSError, "Error logged should match the mock error")
    }

    @Test("Logs response ")
    func logsResponseWhenInjectingLoggerToClient() async {
        let mockLogger = MockNetworkLogger()

        let expectedData = Data("Response data".utf8)
        let expectedResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let client = makeSut(data: expectedData, response: expectedResponse, logger: mockLogger)
        var result: HTTPClient.Result?

        _ = await confirmation("…") { confirmation in
            client.perform(urlRequest: { URLRequest(url: URL(string: "https://example.com")!) }) { responseResult in
                result = responseResult
                confirmation()
            }
        }

        switch result {
        case .success(_):
            #expect(mockLogger.loggedRequests.first?.dataResponse == expectedData, "Response data should match expected data")
            #expect(mockLogger.loggedRequests.first?.response == expectedResponse, "Response should match expected HTTPURLResponse")
        default:
            Issue.record("Expected a successful response, but got \(String(describing: result))")
        }
    }
}
