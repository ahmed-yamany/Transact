//
//  HTTPClientTask.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 20/12/2024.
//
import Foundation

public protocol HTTPClientTask {
    func cancel()
}


public struct URLSessionTaskWrapper: HTTPClientTask {
    let wrapped: URLSessionTask

    public func cancel() {
        wrapped.cancel()
    }
}
