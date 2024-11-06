//
//  PasswordMatchValidator.swift
//  Shared
//
//  Created by Ahmed Yamany on 06/11/2024.
//

import Foundation
import Localization

public struct PasswordMatch {
    public let password: String
    public let confirmPassword: String

    public init(password: String, confirmPassword: String) {
        self.password = password
        self.confirmPassword = confirmPassword
    }
}

struct PasswordMatchValidator: Validator {
    func validate(_ value: PasswordMatch) throws {
        if value.password != value.confirmPassword {
            throw PasswordMatchError()
        }
    }
}

struct PasswordMatchError: Error {
    var errorDescription: String? {
        L10n.Error.passwordMatch
    }
}
