//
//  Default.swift
//  
//
//  Created by Ahmed Yamany on 23/08/2024.
//

import Foundation

public struct DefaultHTTPEndPointDecorator: HTTPEndPoint {
    public var url: String { endPoint.url}
    public var method: HTTPMethod { endPoint.method }
    public var task: HTTPEndPointTask { endPoint.task }
    public var headers: Headers?
    public var timeInterval: TimeInterval { endPoint.timeInterval }
    
    let endPoint: HTTPEndPoint
    
    public init(endPoint: HTTPEndPoint, languageProvider: @escaping () -> String) {
        self.endPoint = endPoint

        headers = [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Accept-Language": languageProvider(),
            "Lang": languageProvider()
        ].merging(endPoint.headers ?? [:]) { (_, new) in new }
    }
}
