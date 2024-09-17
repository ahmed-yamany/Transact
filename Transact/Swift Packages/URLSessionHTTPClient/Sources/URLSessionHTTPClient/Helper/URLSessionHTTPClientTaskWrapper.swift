//
//  URLSessionHTTPClientTaskWrapper.swift
//
//
//  Created by Ahmed Yamany on 22/08/2024.
//

import Foundation
import HTTPClient

public struct URLSessionHTTPClientTaskWrapper: HTTPClientTask {
    let wrapped: URLSessionTask

    public func cancel() {
        wrapped.cancel()
    }
}
