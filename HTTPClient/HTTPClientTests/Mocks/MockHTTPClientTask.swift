//
//  MockHTTPClientTask.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 25/12/2024.
//
import Foundation
import HTTPClient

class MockHTTPClientTask: HTTPClientTask {
    var isCanceled = false
    func cancel() {
        isCanceled = true
    }
}
