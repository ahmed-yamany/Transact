//
//  NetworkLoggerTests.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 26/12/2024.
//

@testable import HTTPClient
import XCTest

final class NetworkLoggerTests: XCTestCase {
    private var logger: NetworkLogger!

    override func setUp() {
        super.setUp()
        logger = NetworkLogger()
    }

    func testLogRequestWithResponseAndData() {
        // Arrange
        let request = URLRequest(url: URL(string: "https://example.com/api")!)
        let response = HTTPURLResponse(
            url: request.url!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: ["Content-Type": "application/json"]
        )
        let data = """
        {"key": "value"}
        """.data(using: .utf8)

        // Intercept stdout
        let capturedOutput = captureOutput {
            logger.log(urlRequest: request, response: response, dataResponse: data, error: nil)
        }

        // Assert
        XCTAssertTrue(capturedOutput.contains("🔗🔗🔗 URL: https://example.com/api"))
        XCTAssertTrue(capturedOutput.contains("👉👉👉 method: nil")) // Since no HTTP method is set in the request
        XCTAssertTrue(capturedOutput.contains("📲📲📲 StatusCode: 200"))
        XCTAssertTrue(capturedOutput.contains("✅✅✅ ResponseData: {"))
        XCTAssertTrue(capturedOutput.contains("\"key\": \"value\""))
    }

    func testLogRequestWithError() {
        // Arrange
        let request = URLRequest(url: URL(string: "https://example.com/api")!)
        let error = NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Something went wrong"])

        // Intercept stdout
        let capturedOutput = captureOutput {
            logger.log(urlRequest: request, response: nil, dataResponse: nil, error: error)
        }

        // Assert
        XCTAssertTrue(capturedOutput.contains("🔗🔗🔗 URL: https://example.com/api"))
        XCTAssertTrue(capturedOutput.contains("❌❌❌ ERROR: Something went wrong"))
    }

    func testLogRequestWithoutBody() {
        // Arrange
        var request = URLRequest(url: URL(string: "https://example.com/api")!)
        request.httpMethod = "POST"

        // Intercept stdout
        let capturedOutput = captureOutput {
            logger.log(urlRequest: request, response: nil, dataResponse: nil, error: nil)
        }

        // Assert
        XCTAssertTrue(capturedOutput.contains("🔗🔗🔗 URL: https://example.com/api"))
        XCTAssertTrue(capturedOutput.contains("👉👉👉 method: POST"))
        XCTAssertFalse(capturedOutput.contains("🧠🧠🧠 Body:")) // No body was set
    }

    // Helper function to capture print output
    private func captureOutput(_ closure: () -> Void) -> String {
        let pipe = Pipe()
        let previousStdout = dup(fileno(stdout))
        dup2(pipe.fileHandleForWriting.fileDescriptor, fileno(stdout))

        let outputExpectation = expectation(description: "Wait for output")
        DispatchQueue.global(qos: .background).async {
            closure()
            outputExpectation.fulfill()
        }

        wait(for: [outputExpectation], timeout: 1.0)

        pipe.fileHandleForWriting.closeFile()
        dup2(previousStdout, fileno(stdout))

        let outputData = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: outputData, encoding: .utf8) ?? ""
    }
}
