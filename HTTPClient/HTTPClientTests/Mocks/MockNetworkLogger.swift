//
//  MockNetworkLogger.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 25/12/2024.
//
import Foundation
import HTTPClient

class MockNetworkLogger: NetworkLoggerProtocol {
    var loggedRequests: [(urlRequest: URLRequest, response: HTTPURLResponse?, dataResponse: Data?, error: Error?)] = []

    func log(urlRequest: URLRequest, response: HTTPURLResponse?, dataResponse: Data?, error: Error?) {
        loggedRequests.append((urlRequest, response, dataResponse, error))
    }
}
