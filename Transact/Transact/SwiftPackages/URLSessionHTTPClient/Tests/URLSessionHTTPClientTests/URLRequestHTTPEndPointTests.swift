//
//  URLRequestHTTPEndPointTests.swift
//  
//
//  Created by Ahmed Yamany on 23/08/2024.
//

import XCTest
@testable import URLSessionHTTPClient
@testable import HTTPClient

final class URLRequestHTTPEndPointTests: XCTestCase {

    func test_URLRequestHTTPEndPoint_URL() {
        let endpoint = HTTPEndPointPlainTaskDummy()
        let sut = URLRequest(endpoint: endpoint)
        XCTAssertEqual(sut.url?.absoluteString, "https://facebook.com")
    }
    
    func test_URLRequestHTTPEndPoint_TimeInterval_Expected60() {
        let endpoint = HTTPEndPointQueryTaskDummy()
        let sut = URLRequest(endpoint: endpoint)
        XCTAssertEqual(sut.timeoutInterval, 60)
    }
    
    func test_URLRequestHTTPEndPoint_TimeInterval_Expected20() {
        let endpoint = HTTPEndPointPlainTaskDummy()
        let sut = URLRequest(endpoint: endpoint)
        XCTAssertEqual(sut.timeoutInterval, 20)
    }
    
    func test_URLRequestHTTPEndPoint_HTTPMethod_ExpectedGet() {
        let endpoint = HTTPEndPointPlainTaskDummy()
        let sut = URLRequest(endpoint: endpoint)
        XCTAssertEqual(sut.httpMethod, HTTPMethod.get.rawValue)
    }
    
    func test_URLRequestHTTPEndPoint_HTTPMethod_ExpectedPost() {
        let endpoint = HTTPEndPointBodyWithQueryTaskDummy()
        let sut = URLRequest(endpoint: endpoint)
        XCTAssertEqual(sut.httpMethod, HTTPMethod.post.rawValue)
    }
    
    func test_URLRequestHTTPEndPoint_Headers() {
        let endpoint = HTTPEndPointMultiPartWithQueryTaskDummy()
        let sut = URLRequest(endpoint: endpoint)
        XCTAssertEqual(sut.allHTTPHeaderFields?.keys.map{$0.lowercased()}, ["content-type"])
        XCTAssertEqual(sut.allHTTPHeaderFields?.values.map{$0.lowercased()}, ["json"])
    }
    
    func test_URLRequestHTTPEndPoint_Body() {
        let endpoint = HTTPEndPointBodyTaskDummy()
        let sut = URLRequest(endpoint: endpoint)
        let body = try? JSONDecoder().decode(BodyDummy.self, from: sut.httpBody ?? Data())
        XCTAssertEqual(body?.name, "Ahmed")
        XCTAssertEqual(body?.age, 22)
    }
    
    func test_URLRequestHTTPEndPoint_BodyWithQuery() {
        let endpoint = HTTPEndPointBodyWithQueryTaskDummy()
        let sut = URLRequest(endpoint: endpoint)
        let body = try? JSONDecoder().decode(BodyDummy.self, from: sut.httpBody ?? Data())
        XCTAssertEqual(body?.name, "Ahmed")
        XCTAssertEqual(body?.age, 22)
    }
}

struct HTTPEndPointBodyTaskDummy: HTTPEndPoint {
    var url: String = ""
    var method: HTTPMethod = .post
    var task: HTTPEndPointTask = .body(BodyDummy(name: "Ahmed", age: 22))
    var headers: Headers?
}

struct BodyDummy: Codable {
    let name: String
    let age: Int
}
