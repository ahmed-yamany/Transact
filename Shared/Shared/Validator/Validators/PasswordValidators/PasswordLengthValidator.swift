//
//  PasswordLengthValidator.swift
//  Shared
//
//  Created by Ahmed Yamany on 06/11/2024.
//

import Foundation
import Localization

public struct PasswordLengthValidator: Validator {
    public init() {}

    public func validate(_ value: String) throws {
        if value.count < 8 {
            throw PasswordLengthError()
        }
    }
}

private struct PasswordLengthError: Error, LocalizedError {
    var errorDescription: String? {
        L10n.Error.passwordLength
    }
}
