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
        
        static func == (lhs: MockErrorResponse, rhs: MockErrorResponse) -> Bool {
            lhs.code == rhs.code && lhs.errorMessage == rhs.errorMessage
        }
    }

    func makeSut(mockData: Data) throws -> MockSuccessResponse {
        let httpResponse = HTTPClientResponse(data: mockData, response: HTTPURLResponse())
        let decoder = JSONDecoder()

        return try httpResponse.decode(to: MockSuccessResponse.self, errorType: MockErrorResponse.self, using: decoder)
    }

    @Test("Successful decoding")
    func testDecodeSuccessfulResponse() throws {
        let mockData = """
        {
            "id": 1,
            "message": "Success"
        }
        """.data(using: .utf8)!

        let result = try makeSut(mockData: mockData)
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

        do {
            _ = try makeSut(mockData: mockErrorData)
            Issue.record("Expected an error to be thrown")
        } catch let error as MockErrorResponse {
            #expect(error == MockErrorResponse(code: 401, errorMessage: "Unauthorized access"))
        }
    }

    @Test("Decoding failure for both types")
    func testDecodeFailureForBothTypes() throws {
        let invalidData = "Invalid JSON".data(using: .utf8)!
        do {
            _ = try makeSut(mockData: invalidData)
            Issue.record("Expected an error to be thrown")
        } catch {
            #expect(true, "An unknown decoding error occurred")
        }
    }
}
