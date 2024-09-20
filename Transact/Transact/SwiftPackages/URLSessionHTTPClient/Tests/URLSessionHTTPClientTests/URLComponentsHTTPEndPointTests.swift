//
//  URLComponentsHTTPEndPointTests.swift
//  
//
//  Created by Ahmed Yamany on 24/08/2024.
//

import XCTest
@testable import URLSessionHTTPClient
@testable import HTTPClient

final class URLComponentsHTTPEndPointTests: XCTestCase {
    
    func test_URLComponentsHTTPEndPoint_plainTask_url() {
        let endpoint = HTTPEndPointPlainTaskDummy()
        let sut = URLComponents(endpoint: endpoint)
        XCTAssertEqual(sut?.url?.absoluteString, "https://facebook.com")
    }
    
    func test_URLComponentsHTTPEndPoint__plainTask_QueryItems_ExpectedNil() {
        let endpoint = HTTPEndPointPlainTaskDummy()
        let sut = URLComponents(endpoint: endpoint)
        XCTAssertNil(sut?.queryItems)
    }
    
    func test_URLComponentsHTTPEndPoint_QueryTask_QueryItems_ExpectedNameAndValue() {
        let endpoint = HTTPEndPointQueryTaskDummy()
        let sut = URLComponents(endpoint: endpoint)
        XCTAssertEqual(sut?.queryItems?.first?.name, "name")
        XCTAssertEqual(sut?.queryItems?.first?.value, "Ahmed")
        XCTAssertEqual(sut?.queryItems?.first, URLQueryItem(name: "name", value: "Ahmed"))
    }
    
    func test_URLComponentsHTTPEndPoint_BodyWithQueryTask_QueryItems_ExpectedNameAndValue() {
        let endpoint = HTTPEndPointBodyWithQueryTaskDummy()
        let sut = URLComponents(endpoint: endpoint)
        XCTAssertEqual(sut?.queryItems?.first?.name, "name")
        XCTAssertEqual(sut?.queryItems?.first?.value, "Ahmed")
        XCTAssertEqual(sut?.queryItems?.first, URLQueryItem(name: "name", value: "Ahmed"))
    }
    
    func test_URLComponentsHTTPEndPoint_MultiPartWithQueryTask_QueryItems_ExpectedNameAndValue() {
        let endpoint = HTTPEndPointMultiPartWithQueryTaskDummy()
        let sut = URLComponents(endpoint: endpoint)
        XCTAssertEqual(sut?.queryItems?.first?.name, "name")
        XCTAssertEqual(sut?.queryItems?.first?.value, "Ahmed")
        XCTAssertEqual(sut?.queryItems?.first, URLQueryItem(name: "name", value: "Ahmed"))
    }
}

struct HTTPEndPointPlainTaskDummy: HTTPEndPoint {
    var url: String = "https://facebook.com"
    var method: HTTPMethod = .get
    var task: HTTPEndPointTask = .plain
    var headers: Headers?
    var timeInterval: TimeInterval = 20
}

struct HTTPEndPointQueryTaskDummy: HTTPEndPoint {
    var url: String = ""
    var method: HTTPMethod = .get
    var task: HTTPEndPointTask = .query(["name": "Ahmed"])
    var headers: Headers?
}

struct HTTPEndPointBodyWithQueryTaskDummy: HTTPEndPoint {
    var url: String = ""
    var method: HTTPMethod = .post
    var task: HTTPEndPointTask = .bodyWithQuery((BodyDummy(name: "Ahmed", age: 22), ["name": "Ahmed"]))
    var headers: Headers?
}

struct HTTPEndPointMultiPartWithQueryTaskDummy: HTTPEndPoint {
    var url: String = ""
    var method: HTTPMethod = .get
    var task: HTTPEndPointTask = .multipartWithQuery(([], ["name": "Ahmed"]))
    var headers: Headers? = ["content-type": "json"]
}

