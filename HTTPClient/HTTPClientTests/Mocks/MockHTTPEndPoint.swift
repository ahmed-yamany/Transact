//
//  MockHTTPEndPoint.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 26/12/2024.
//
import Foundation
import HTTPClient

struct MockHTTPEndPoint: HTTPEndPoint {
    let url: String
    let method: HTTPMethod
    let task: HTTPEndPointTask
    let headers: [String: String]?
    let timeInterval: TimeInterval
    let encoder: JSONEncoder
}
