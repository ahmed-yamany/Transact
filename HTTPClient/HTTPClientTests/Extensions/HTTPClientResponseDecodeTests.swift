//
//  HTTPClientResponseDecodeTests.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 23/12/2024.
//
import Foundation
@testable import HTTPClient
import Testing

@Suite("HTTPClientResponse + Decode")
struct HTTPClientResponseDecodeTests {
    struct MockSuccessResponse: Decodable, Equatable {
        let id: Int
        let message: String
    }

    struct MockErrorResponse: Decodable, Error, Equatable {
        let code: Int
        let errorMessage: String
    }

    @Test("Successful decoding")
    func testDecodeSuccessfulResponse() throws {
        let mockData = """
        {
            "id": 1,
            "message": "Success"
        }
        """.data(using: .utf8)!
        let httpResponse = HTTPClientResponse(data: mockData, response: HTTPURLResponse())
        let decoder = JSONDecoder()

        let result = try httpResponse.decode(to: MockSuccessResponse.self, errorType: MockErrorResponse.self, using: decoder)

        #expect(result == MockSuccessResponse(id: 1, message: "Success"))
    }

    @Test("Error decoding with valid error response")
    func testDecodeErrorResponse() throws {
        let mockErrorData = """
        {
            "code": 401,
            "errorMessage": "Unauthorized access"
        }
        """.data(using: .utf8)!
        let httpResponse = HTTPClientResponse(data: mockErrorData, response: HTTPURLResponse())
        let decoder = JSONDecoder()

        do {
            _ = try httpResponse.decode(to: MockSuccessResponse.self, errorType: MockErrorResponse.self, using: decoder)

            Issue.record("Expected an error to be thrown")
        } catch let error as MockErrorResponse {
            #expect(error == MockErrorResponse(code: 401, errorMessage: "Unauthorized access"))
        }
    }

    @Test("Decoding failure for both types")
    func testDecodeFailureForBothTypes() throws {
        let invalidData = "Invalid JSON".data(using: .utf8)!
        let httpResponse = HTTPClientResponse(data: invalidData, response: HTTPURLResponse())
        let decoder = JSONDecoder()

        do {
            _ = try httpResponse.decode(to: MockSuccessResponse.self, errorType: MockErrorResponse.self, using: decoder)

            Issue.record("Expected an error to be thrown")
        } catch {
            #expect(true, "An unknown decoding error occurred")
        }
    }
}
