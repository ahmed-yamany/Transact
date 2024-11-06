//
//  PasswordNumberValidator.swift
//  Shared
//
//  Created by Ahmed Yamany on 06/11/2024.
//

import Foundation
import Localization

public struct PasswordNumberValidator: Validator {
    public init() {}

    public func validate(_ value: String) throws {
        let numberRegex = ".*[0-9]+.*"
        let letterPredicate = NSPredicate(format: "SELF MATCHES %@", numberRegex)
        if !letterPredicate.evaluate(with: value) {
            throw PasswordNumberError()
        }
    }
}

private struct PasswordNumberError: Error, LocalizedError {
    var errorDescription: String? {
        L10n.Error.passwordLetter
    }
}
