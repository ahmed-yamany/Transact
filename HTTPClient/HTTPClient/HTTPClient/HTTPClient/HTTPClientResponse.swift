//
//  HTTPClientResponse.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 25/12/2024.
//
import Foundation

public struct HTTPClientResponse {
    public let data: Data
    public let response: HTTPURLResponse

    public init(data: Data, response: HTTPURLResponse) {
        self.data = data
        self.response = response
    }
}
