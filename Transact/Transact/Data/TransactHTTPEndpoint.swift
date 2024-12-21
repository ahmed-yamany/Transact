//
//  TransactHTTPEndpoint.swift
//  Transact
//
//  Created by Ahmed Yamany on 21/12/2024.
//

import Foundation
import HTTPClient

protocol TransactHTTPEndpoint: HTTPEndPoint {
    var path: String { get }
}

extension TransactHTTPEndpoint {
    var url: String { "url/\(path)" }
    var timeInterval: TimeInterval { 30 }
    var encoder: JSONEncoder { .dateAndSnakeCaseStrategy() }
}
