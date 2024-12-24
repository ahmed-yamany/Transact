//
//  MultiPartAuthenticatedHTTPEndPointDecoratorTests.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 23/12/2024.
//
import Foundation
@testable import HTTPClient
import Testing

@Suite("MultiPartAuthenticatedHTTPEndPointDecorator")
struct MultiPartAuthenticatedHTTPEndPointDecoratorTests {
    struct MockHTTPEndPoint: HTTPEndPoint {
        let url: String
        let method: HTTPMethod
        let task: HTTPEndPointTask
        let headers: [String: String]?
        let timeInterval: TimeInterval
        let encoder: JSONEncoder
    }

    @Test("Decorator sets multipart headers correctly")
    func decoratorSetsMultipartHeaders() async {
        // Arrange
        let mockEndPoint = MockHTTPEndPoint(
            url: "https://api.example.com/upload",
            method: .post,
            task: .plain,
            headers: ["X-Custom-Header": "CustomValue"],
            timeInterval: 120.0,
            encoder: JSONEncoder()
        )

        let boundary = "Boundary123"
        let tokenProvider: () async -> String = { "mockToken" }
        let languageProvider: () async -> String = { "en-US" }

        // Act
        let decorator = await MultiPartAuthenticatedHTTPEndPointDecorator(
            endPoint: mockEndPoint,
            boundary: boundary,
            tokenProvider: tokenProvider,
            languageProvider: languageProvider
        )

        // Assert
        #expect(decorator.headers?["Accept"] == "application/json", "Accept header should be set to application/json.")
        #expect(decorator.headers?["Content-Type"] == "multipart/form-data; boundary=\(boundary)", "Content-Type header should include the correct boundary.")
        #expect(decorator.headers?["Authorization"] == "Bearer mockToken", "Authorization header should include the provided token.")
        #expect(decorator.headers?["Accept-Language"] == "en-US", "Accept-Language header should match the language provider.")
        #expect(decorator.headers?["Lang"] == "en-US", "Lang header should match the language provider.")
        #expect(decorator.headers?["X-Custom-Header"] == "CustomValue", "Original headers should be merged with multipart headers.")
        #expect(decorator.url == mockEndPoint.url, "Decorator should retain the original URL.")
        #expect(decorator.method == mockEndPoint.method, "Decorator should retain the original HTTP method.")
    }

    @Test("Multipart extension creates decorator correctly")
    func multipartExtensionCreatesDecorator() async {
        // Arrange
        let mockEndPoint = MockHTTPEndPoint(
            url: "https://api.example.com/upload",
            method: .post,
            task: .plain,
            headers: ["X-Extra-Header": "ExtraValue"],
            timeInterval: 100.0,
            encoder: JSONEncoder()
        )

        let boundary = "Boundary456"
        let tokenProvider: () async -> String = { "testToken" }
        let languageProvider: () async -> String = { "fr-FR" }

        // Act
        let decorator: HTTPEndPoint = await .multipart(
            endPoint: mockEndPoint,
            boundary: boundary,
            tokenProvider: tokenProvider,
            languageProvider: languageProvider
        )

        // Assert
        #expect(decorator.headers?["Accept"] == "application/json", "Accept header should be set to application/json.")
        #expect(decorator.headers?["Content-Type"] == "multipart/form-data; boundary=\(boundary)", "Content-Type header should include the correct boundary.")
        #expect(decorator.headers?["Authorization"] == "Bearer testToken", "Authorization header should include the provided token.")
        #expect(decorator.headers?["Accept-Language"] == "fr-FR", "Accept-Language header should match the language provider.")
        #expect(decorator.headers?["Lang"] == "fr-FR", "Lang header should match the language provider.")
        #expect(decorator.headers?["X-Extra-Header"] == "ExtraValue", "Original headers should be merged with multipart headers.")
        #expect(decorator.url == mockEndPoint.url, "Decorator should retain the original URL.")
        #expect(decorator.timeInterval == mockEndPoint.timeInterval, "Decorator should retain the original timeout.")
    }
}
