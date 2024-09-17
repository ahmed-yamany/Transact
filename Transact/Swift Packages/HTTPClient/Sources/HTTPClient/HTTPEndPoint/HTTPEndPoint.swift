//
//  File.swift
//  
//
//  Created by Ahmed Yamany on 22/08/2024.
//

import Foundation

public typealias Headers = [String: String]

public protocol HTTPEndPoint {
    var url: String { get }
    var method: HTTPMethod { get }
    var task: HTTPEndPointTask { get }
    var headers: Headers? { get }
    var timeInterval: TimeInterval { get }
}

extension HTTPEndPoint {
    var timeInterval: TimeInterval { 60.0 }
}
