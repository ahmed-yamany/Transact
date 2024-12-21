//
//  File.swift
//
//
//  Created by Ahmed Yamany on 23/08/2024.
//

import Foundation

public struct AuthenticatedHTTPEndPointDecorator: HTTPEndPoint {
    public var url: String { endPoint.url }
    public var method: HTTPMethod { endPoint.method }
    public var task: HTTPEndPointTask { endPoint.task }
    public var headers: [String: String]?
    public var timeInterval: TimeInterval { endPoint.timeInterval }
    public var encoder: JSONEncoder { endPoint.encoder }

    let endPoint: HTTPEndPoint

    public init(
        endPoint: HTTPEndPoint,
        tokenProvider: @escaping () async -> String,
        languageProvider: @escaping () async -> String
    ) async {
        self.endPoint = endPoint

        headers = [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer \(await tokenProvider())",
            "Accept-Language": await languageProvider(),
            "Lang": await languageProvider(),
        ].merging(endPoint.headers ?? [:]) { _, new in new }
    }
}

public extension HTTPEndPoint where Self == AuthenticatedHTTPEndPointDecorator {
    static func authenticated(
        endPoint: HTTPEndPoint,
        tokenProvider: @escaping () async -> String,
        languageProvider: @escaping () async -> String
    ) async -> Self {
        await AuthenticatedHTTPEndPointDecorator(
            endPoint: endPoint,
            tokenProvider: tokenProvider,
            languageProvider: languageProvider
        )
    }
}
