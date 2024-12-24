//
//  AuthenticatedHTTPEndPointDecoratorTests.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 23/12/2024.
//
import Foundation
@testable import HTTPClient
import Testing

@Suite("AuthenticatedHTTPEndPointDecorator")
struct AuthenticatedHTTPEndPointDecoratorTests {
    struct MockHTTPEndPoint: HTTPEndPoint {
        let url: String
        let method: HTTPMethod
        let task: HTTPEndPointTask
        let headers: [String: String]?
        let timeInterval: TimeInterval
        let encoder: JSONEncoder
    }

    @Test("Decorator correctly merges headers and adds authentication")
    func decoratorAddsAuthAndMergesHeaders() async throws {
        // Arrange
        let mockEndPoint = MockHTTPEndPoint(
            url: "https://api.example.com/resource",
            method: .get,
            task: .plain,
            headers: ["X-Custom-Header": "CustomValue"],
            timeInterval: 60.0,
            encoder: JSONEncoder()
        )

        let tokenProvider: () async -> String = { "test-token" }
        let languageProvider: () async -> String = { "en-US" }

        // Act
        let decorator = await AuthenticatedHTTPEndPointDecorator(
            endPoint: mockEndPoint,
            tokenProvider: tokenProvider,
            languageProvider: languageProvider
        )

        // Assert
        #expect(decorator.headers?["Authorization"] == "Bearer test-token", "Authorization header should include the provided token.")
        #expect(decorator.headers?["Accept-Language"] == "en-US", "Accept-Language header should match the language provider.")
        #expect(decorator.headers?["Lang"] == "en-US", "Lang header should match the language provider.")
        #expect(decorator.headers?["X-Custom-Header"] == "CustomValue", "Custom headers should be merged with default headers.")
        #expect(decorator.url == mockEndPoint.url, "Decorator should retain the endpoint's URL.")
        #expect(decorator.method == mockEndPoint.method, "Decorator should retain the endpoint's HTTP method.")
    }

    @Test("Authenticated extension creates decorator correctly")
    func authenticatedExtensionCreatesDecorator() async throws {
        // Arrange
        let mockEndPoint = MockHTTPEndPoint(
            url: "https://api.example.com/resource",
            method: .post,
            task: .body(EmptyBody()),
            headers: ["X-Extra-Header": "ExtraValue"],
            timeInterval: 120.0,
            encoder: JSONEncoder()
        )

        let tokenProvider: () async -> String = { "another-token" }
        let languageProvider: () async -> String = { "fr-FR" }

        // Act
        let decorator: HTTPEndPoint = await .authenticated(
            endPoint: mockEndPoint,
            tokenProvider: tokenProvider,
            languageProvider: languageProvider
        )

        // Assert
        #expect(decorator.headers?["Authorization"] == "Bearer another-token", "Authorization header should include the token from the provider.")
        #expect(decorator.headers?["Accept-Language"] == "fr-FR", "Accept-Language header should match the provider's language.")
        #expect(decorator.headers?["Lang"] == "fr-FR", "Lang header should match the language provider.")
        #expect(decorator.headers?["X-Extra-Header"] == "ExtraValue", "Original headers should be included.")
        #expect(decorator.url == mockEndPoint.url, "Decorator should retain the original URL.")
        #expect(decorator.timeInterval == mockEndPoint.timeInterval, "Decorator should retain the original timeout.")
    }
}
