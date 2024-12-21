//
//  URLRequest+HTTPEndPointTests.swift
//  HTTPClientTests
//
//  Created by Ahmed Yamany on 20/12/2024.
//

import UIKit
@testable import HTTPClient
import Testing

@Suite("URLRequest + HTTPEndPoint")
struct URLRequestHTTPEndPointTests {
    func makeURLRequest(
        url: String = "https://example.com",
        task: HTTPEndPointTask,
        method: HTTPMethod = .get,
        timeInterval: TimeInterval = 0,
        headers: [String: String]? = nil
    ) -> URLRequest {
        let endpoint = HTTPEndPointStub(url: url, method: method, task: task, headers: headers, timeInterval: timeInterval)
        return URLRequest(endpoint: endpoint)
    }
    
    @Test
    func endpointTaskIsPrain_requestUrlShouldBePlained() {
        let url = "https://facebook.com"
        let sut = makeURLRequest(url: url, task: .plain)
        #expect(sut.url?.absoluteString == url)
    }

    @Test("query", arguments: [
        HTTPEndPointTask.query(["name": "Test Name"]),
        .bodyWithQuery((body: EmptyBody(), query: ["name": "Test Name"])),
        .multipartWithQuery((multipart: [], query: ["name": "Test Name"])),
    ])
    func endpointTaskIsQuery_requestShouldHaveCorrectQueryItems(task: HTTPEndPointTask) throws {
        let sut = makeURLRequest(task: task)
        let url = try #require(sut.url?.absoluteString)
        #expect(url.contains("name=Test%20Name"), "when the endpoint task type is \(task), the request URL should include query items")
    }

    @Test
    func endPointTimeInterval_requestShouldHaveCorrectTimeInterval() async throws {
        let timeInterval: TimeInterval = 10
        let sut = makeURLRequest(task: .plain, timeInterval: timeInterval)
        #expect(sut.timeoutInterval == timeInterval, "the request should have the correct time interval")
    }

    @Test
    func endpointTaskIsPlain_requestShouldHaveCorrectURLAndHeaders() async throws {
        let url = "https://example.com"
        let headers = ["Authorization": "Bearer token"]
        let sut = makeURLRequest(url: url, task: .plain, method: .get, headers: headers)

        #expect(sut.url?.absoluteString == url, "when the endpoint task type is plain, the request should have the correct URL")
        let authorizationHeader = try #require(sut.value(forHTTPHeaderField: "Authorization"))
        #expect(authorizationHeader == "Bearer token", "when headers are provided, they should be added to the request")
        #expect(sut.httpMethod == "GET", "the request should have the correct HTTP method")
    }
    
    
    @Test("body")
    func endpointTaskIsBody_requestShouldHaveCorrectBody() throws {
        let body = BodyStub(name: "test name")
        let sut = makeURLRequest(url: "https://example.com", task: .body(body), method: .post)
        #expect(sut.httpMethod == "POST", "the request should have the correct HTTP method")
        
        let bodyData = try #require(sut.httpBody, "when the endpoint task type is body, the request should have a body")
        let decodedBody = try JSONDecoder().decode(BodyStub.self, from: bodyData)
        #expect(decodedBody == body, "the body should match the provided Encodable")
    }
    
    
    @Test("body with query")
    func endpointTaskIsBodyWithQuery_requestShouldHaveCorrectBodyAndQuery() throws {
        let body = BodyStub(name: "test name")
        let query = ["name": "Test Name"]
        let sut = makeURLRequest(url: "https://example.com", task: .bodyWithQuery((body: body, query: query)), method: .post)
        
        let bodyData = try #require(sut.httpBody, "when the endpoint task type is body with query, the request should have a body")
        let decodedBody = try JSONDecoder().decode(BodyStub.self, from: bodyData)
        #expect(decodedBody == body, "the body should match the provided Encodable")
        #expect(sut.url?.absoluteString.contains("name=Test%20Name") == true, "the request URL should include query items")
    }
    
    
    @Test("multipart")
    func endpointTaskIsMultipart_requestShouldHaveMultipartBody() throws {
        let boundary = "Boundary-\(UUID().uuidString)"

        let multipart = [MultipartItem(boundary: boundary, objectDic: ["image": UIImage().pngData() as Any], type: .png)]
        let sut = makeURLRequest(url: "https://example.com", task: .multipart(multipart: multipart), method: .post)
        let bodyData = try #require(sut.httpBody, "when the endpoint task type is multipart, the request should have a body")
        #expect(bodyData.count > 0, "the multipart body should be correctly encoded")
    }
}
