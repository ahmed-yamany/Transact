//
//  HTTPSession.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 26/12/2024.
//
import Foundation

public protocol HTTPSession {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, (any Error)?) -> Void) -> URLSessionDataTask
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: HTTPSession { }
