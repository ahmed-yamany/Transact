//
//  ForgotpasswordPasswordService.swift
//  Transact
//
//  Created by Ahmed Yamany on 07/11/2024.
//

import Foundation
import HTTPClient
import Password

struct ForgotpasswordPasswordService: PasswordServiceInterface {
    let client: HTTPClient

    func updatePassword(_ password: String) async throws {
    }
}
