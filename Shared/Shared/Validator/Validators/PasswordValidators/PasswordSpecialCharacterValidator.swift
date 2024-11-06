//
//  PasswordSpecialCharacterValidator.swift
//  Shared
//
//  Created by Ahmed Yamany on 06/11/2024.
//

import Foundation
import Localization

public struct PasswordSpecialCharacterValidator: Validator {
    public init() {}

    public func validate(_ value: String) throws {
        let specialCharacterRegex = ".*[!@#$%^&*(),.?\":{}|<>]+.*"
        let letterPredicate = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegex)
        if !letterPredicate.evaluate(with: value) {
            throw PasswordSpecialCharacterError()
        }
    }
}

private struct PasswordSpecialCharacterError: Error, LocalizedError {
    var errorDescription: String? {
        L10n.Error.passwordSpecialCharacter
    }
}
