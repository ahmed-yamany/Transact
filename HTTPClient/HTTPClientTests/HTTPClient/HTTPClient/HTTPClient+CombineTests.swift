//
//  HTTPClient+CombineTests.swift
//  HTTPClientTests
//
//  Created by Ahmed Yamany on 26/12/2024.
//

import Combine
import Foundation
@testable import HTTPClient
import Testing
import XCTest

// @Suite("HTTPClient+Combine Tests")
class HTTPClientCombineTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []

    func testPerformURLRequestSuccess() {
        // Arrange
        let mockClient = MockHTTPClient()
        let expectedResponse = HTTPClientResponse(data: Data("Success".utf8), response: HTTPURLResponse())
        mockClient.result = .success(expectedResponse)

        let urlRequest = URLRequest(url: URL(string: "https://example.com")!)
        let expectation = XCTestExpectation(description: "Should receive success response")

        // Act
        mockClient.perform(urlRequest: { urlRequest })
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    Issue.record("Unexpected failure")
                }
            }, receiveValue: { response in
                #expect(response.data == Data("Success".utf8))
                expectation.fulfill()
            })
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testPerformURLRequestFailure() {
        // Arrange
        let mockClient = MockHTTPClient()
        let expectedError = URLError(.timedOut)
        mockClient.result = .failure(expectedError)

        let urlRequest = URLRequest(url: URL(string: "https://example.com")!)
        let expectation = XCTestExpectation(description: "Should receive failure response")

        // Act
        mockClient.perform(urlRequest: { urlRequest })
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    #expect(error as? URLError == expectedError)
                    expectation.fulfill()
                } else {
                    Issue.record("Expected failure but got success")
                }
            }, receiveValue: { _ in
                Issue.record("Expected failure but got success")
            })
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testPerformURLRequestCancellation() {
        // Arrange
        let mockClient = MockHTTPClient()
        let task = MockHTTPClientTask()
        mockClient.task = task

        let urlRequest = URLRequest(url: URL(string: "https://example.com")!)
        let expectation = XCTestExpectation(description: "Task should be canceled")

        // Act
        let publisher = mockClient.perform(urlRequest: { urlRequest })

        publisher
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
            .store(in: &cancellables)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.cancellables.forEach { $0.cancel() }
            #expect(task.isCanceled)
            expectation.fulfill()
        }

        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testPerformEndpointSuccess() {
        // Arrange
        let mockClient = MockHTTPClient()
        let expectedResponse = HTTPClientResponse(data: Data("Success".utf8), response: HTTPURLResponse())
        mockClient.result = .success(expectedResponse)

        struct MockEndpoint: HTTPEndPoint {
            var url: String { "https://example.com" }
            var method: HTTPMethod { .get }
            var task: HTTPEndPointTask { .plain }
            var headers: [String: String]? { nil }
            var timeInterval: TimeInterval { 60 }
            var encoder: JSONEncoder { JSONEncoder() }
        }

        let endpoint = MockEndpoint()
        let expectation = XCTestExpectation(description: "Should receive success response for endpoint")

        // Act
        mockClient.perform(endpoint: { endpoint })
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    Issue.record("Unexpected failure")
                }
            }, receiveValue: { response in
                #expect(response.data == Data("Success".utf8))
                expectation.fulfill()
            })
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1.0)
    }
}
