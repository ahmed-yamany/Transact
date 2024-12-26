//
//  HTTPEndPointStub.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 20/12/2024.
//
import Foundation
@testable import HTTPClient

struct HTTPEndPointStub: HTTPEndPoint {
    var url: String = "testurl.com"
    var method: HTTPMethod = .get
    var task: HTTPEndPointTask
    var headers: [String: String]? = nil
    var timeInterval: TimeInterval = 60
}

struct EmptyBody: Codable, Equatable {}

struct BodyStub: Codable, Equatable {
    let name: String
}
