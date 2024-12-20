//
//  File.swift
//
//
//  Created by Ahmed Yamany on 22/08/2024.
//

import Foundation

public protocol HTTPEndPoint {
    var url: String { get }
    var method: HTTPMethod { get }
    var task: HTTPEndPointTask { get }
    var headers: [String: String]? { get }
    var timeInterval: TimeInterval { get }
}

extension HTTPEndPoint {
    var timeInterval: TimeInterval { 60.0 }
}
