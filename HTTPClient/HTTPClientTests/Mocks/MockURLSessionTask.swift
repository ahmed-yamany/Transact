//
//  MockURLSessionTask.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 26/12/2024.
//
import Foundation

class MockURLSessionTask: URLSessionTask {
    var cancelCalled = false

    override func cancel() {
        cancelCalled = true
    }
}
