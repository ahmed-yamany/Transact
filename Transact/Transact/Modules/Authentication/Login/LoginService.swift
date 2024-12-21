//
//  LoginService.swift
//  Transact
//
//  Created by Ahmed Yamany on 25/10/2024.
//

import Foundation
import HTTPClient
import Login

class LoginService: LoginServiceInterface {
    let client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }

    func login(_ model: LoginModel) async throws {
        _ = try await client.perform(endpoint: { await .login(model) }) as EmptyResponse
    }
}
