//
//  InvalidHTTPResponseError.swift
//  HTTPClient
//
//  Created by Ahmed Yamany on 25/12/2024.
//
import Foundation

public struct InvalidHTTPResponseError: Error, LocalizedError {
    public var errorDescription: String? { "Invalid HTTP response" }
}
