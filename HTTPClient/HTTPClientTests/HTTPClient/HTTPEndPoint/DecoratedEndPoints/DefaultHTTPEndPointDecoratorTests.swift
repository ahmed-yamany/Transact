//
//  DefaultHTTPEndPointDecoratorTests.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 23/12/2024.
//
import Foundation
@testable import HTTPClient
import Testing

@Suite("DefaultHTTPEndPointDecorator")
struct DefaultHTTPEndPointDecoratorTests {
    struct MockHTTPEndPoint: HTTPEndPoint {
        let url: String
        let method: HTTPMethod
        let task: HTTPEndPointTask
        let headers: [String: String]?
        let timeInterval: TimeInterval
        let encoder: JSONEncoder
    }

    @Test("Decorator correctly merges headers and adds default values")
    func decoratorAddsDefaultHeadersAndMerges() {
        // Arrange
        let mockEndPoint = MockHTTPEndPoint(
            url: "https://api.example.com/resource",
            method: .post,
            task: .plain,
            headers: ["X-Custom-Header": "CustomValue"],
            timeInterval: 60.0,
            encoder: JSONEncoder()
        )

        let languageProvider: () -> String = { "en-US" }

        // Act
        let decorator = DefaultHTTPEndPointDecorator(endPoint: mockEndPoint, languageProvider: languageProvider)

        // Assert
        #expect(decorator.headers?["Accept"] == "application/json", "Accept header should be set to application/json.")
        #expect(decorator.headers?["Content-Type"] == "application/json", "Content-Type header should be set to application/json.")
        #expect(decorator.headers?["Accept-Language"] == "en-US", "Accept-Language header should match the language provider.")
        #expect(decorator.headers?["Lang"] == "en-US", "Lang header should match the language provider.")
        #expect(decorator.headers?["X-Custom-Header"] == "CustomValue", "Original headers should be merged with default headers.")
        #expect(decorator.url == mockEndPoint.url, "Decorator should retain the original URL.")
        #expect(decorator.method == mockEndPoint.method, "Decorator should retain the original HTTP method.")
    }

    @Test("Default extension creates decorator correctly")
    func defaultExtensionCreatesDecorator() {
        // Arrange
        let encoder = JSONEncoder()
        let mockEndPoint = MockHTTPEndPoint(
            url: "https://api.example.com/resource",
            method: .get,
            task: .plain,
            headers: ["X-Extra-Header": "ExtraValue"],
            timeInterval: 30.0,
            encoder: encoder
        )

        let languageProvider: () -> String = { "fr-FR" }

        // Act
        let decorator: HTTPEndPoint = .default(endPoint: mockEndPoint, languageProvider: languageProvider)

        // Assert
        #expect(decorator.headers?["Accept"] == "application/json", "Accept header should be set to application/json.")
        #expect(decorator.headers?["Content-Type"] == "application/json", "Content-Type header should be set to application/json.")
        #expect(decorator.headers?["Accept-Language"] == "fr-FR", "Accept-Language header should match the language provider.")
        #expect(decorator.headers?["Lang"] == "fr-FR", "Lang header should match the language provider.")
        #expect(decorator.headers?["X-Extra-Header"] == "ExtraValue", "Original headers should be merged with default headers.")
        #expect(decorator.url == mockEndPoint.url, "Decorator should retain the original URL.")
        #expect(decorator.timeInterval == mockEndPoint.timeInterval, "Decorator should retain the original timeout.")
    }
}
