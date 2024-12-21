//
//  HTTPEndPoint+authenticated.swift
//  Transact
//
//  Created by Ahmed Yamany on 21/12/2024.
//

import Foundation
import HTTPClient
import Localization

extension HTTPEndPoint where Self == AuthenticatedHTTPEndPointDecorator {
    static func authenticated(_ endpoint: HTTPEndPoint) async -> Self {
        await .authenticated(
            endPoint: endpoint,
            tokenProvider: {
                "user-token"
            },
            languageProvider: {
                await LocalizationSettings.shared.getLanguage().local.identifier
            }
        )
    }
}
