//
//  EncodablePrepareBodyTests.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 21/12/2024.
//
import Testing
@testable import HTTPClient
import Foundation

@Suite("JSONEncoder Extensions Tests")
struct JSONEncoderExtensionsTests {
    struct TestObject: Encodable {
        let id: Int
        let createdAt: Date
        let userName: String
    }

    @Test("Custom Encoder encodes date and keys correctly")
    func testDateAndSnakeCaseStrategy() throws {
        // Arrange
        let testDate = Date(timeIntervalSince1970: 0) // Jan 1, 1970
        let testObject = TestObject(id: 1, createdAt: testDate, userName: "testUser")
        let encoder = JSONEncoder.dateAndSnakeCaseStrategy()
        
        // Act
        let jsonData = try #require(try? encoder.encode(testObject))
        let jsonString = try #require(String(data: jsonData, encoding: .utf8), "JSON string must not be nil")

        // Assert
        #expect(jsonString.contains("\"created_at\":\"01-01-1970\""), "Date should be formatted as dd-MM-yyyy")
        #expect(jsonString.contains("\"user_name\":\"testUser\""), "Keys should be converted to snake_case")
        #expect(jsonString.contains("\"id\":1"), "Integer values should be encoded correctly")
    }
}
