//
//  File.swift
//
//
//  Created by Ahmed Yamany on 23/08/2024.
//

import Foundation

// swiftlint: disable type_name
public struct MultiPartAuthenticatedHTTPEndPointDecorator: HTTPEndPoint {
    public var url: String { endPoint.url }
    public var method: HTTPMethod { endPoint.method }
    public var task: HTTPEndPointTask { endPoint.task }
    public var headers: [String: String]?
    public var timeInterval: TimeInterval { endPoint.timeInterval }
    public var encoder: JSONEncoder { endPoint.encoder }

    let endPoint: HTTPEndPoint

    public init(
        endPoint: HTTPEndPoint,
        boundary: String,
        tokenProvider: @escaping () async -> String,
        languageProvider: @escaping () async -> String
    ) async {
        self.endPoint = endPoint
        let language = await languageProvider()

        headers = [
            "Accept": "application/json",
            "Content-Type": "multipart/form-data; boundary=\(boundary)",
            "Authorization": "Bearer \(await tokenProvider())",
            "Accept-Language": language,
            "Lang": language,
        ].merging(endPoint.headers ?? [:]) { _, new in new }
    }
}

public extension HTTPEndPoint where Self == MultiPartAuthenticatedHTTPEndPointDecorator {
    static func multipart(
        endPoint: HTTPEndPoint,
        boundary: String,
        tokenProvider: @escaping () async -> String,
        languageProvider: @escaping () async -> String
    ) async -> Self {
        await MultiPartAuthenticatedHTTPEndPointDecorator(
            endPoint: endPoint,
            boundary: boundary,
            tokenProvider: tokenProvider,
            languageProvider: languageProvider
        )
    }
}

// swiftlint: enable type_name
