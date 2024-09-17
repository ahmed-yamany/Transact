//
//  HTTPMethods.swift
//  
//
//  Created by Ahmed Yamany on 22/08/2024.
//

import Foundation

public enum HTTPMethod: String, CaseIterable {
    case connect = "CONNECT"
    case delete = "DELETE"
    case get = "GET"
    case head = "HEAD"
    case options = "OPTIONS"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
    case query = "QUERY"
    case trace = "TRACE"
}
