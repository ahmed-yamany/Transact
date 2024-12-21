//
//  URLComponentsHTTPEndPointTests.swift
//
//
//  Created by Ahmed Yamany on 24/08/2024.
//

@testable import HTTPClient
import Testing
import XCTest

@Suite("URLComponents + HTTPEndPoint")
struct URLComponentsHTTPEndPointTests {
    let query = ["name": "Test Name"]

    private func makeURLComponents(task: HTTPEndPointTask, sourceLocation: SourceLocation = #_sourceLocation) throws -> URLComponents {
        let endpoint = HTTPEndPointStub(task: task)
        return try #require(URLComponents(endpoint: endpoint))
    }

    @Test("plain", arguments: [
        HTTPEndPointTask.plain,
        .body(EmptyBody()),
        .multipart(multipart: []),
    ])
    func endpointTaskIsPlain_componentsShouldNotHaveQueryItems(task: HTTPEndPointTask) throws {
        let sut = try makeURLComponents(task: task)
        #expect(sut.queryItems == nil, "when the endpoint task is \(task), components should not have queryItems")
    }

    @Test("query", arguments: [
        HTTPEndPointTask.query(["name": "Test Name"]),
        .bodyWithQuery((body: EmptyBody(), query: ["name": "Test Name"])),
        .multipartWithQuery((multipart: [], query: ["name": "Test Name"])),
    ])
    func endpointTaskIsQuery_componentsShouldHaveQueryItems(task: HTTPEndPointTask) throws {
        let sut = try makeURLComponents(task: task)
        let queryItems = try #require(sut.queryItems, "when the endpoint task is \(task), components should have queryItems")
        #expect(queryItems.first == URLQueryItem(name: "name", value: "Test Name"), "when the endpoint task is \(task), components should have queryItems")
    }
}
