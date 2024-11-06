//
//  PasswordLetterValidator.swift
//  Shared
//
//  Created by Ahmed Yamany on 06/11/2024.
//

import Foundation
import Localization

public struct PasswordLetterValidator: Validator {
    public init() {}

    public func validate(_ value: String) throws {
        let letterRegex = ".*[A-Za-z]+.*"
        let letterPredicate = NSPredicate(format: "SELF MATCHES %@", letterRegex)
        if !letterPredicate.evaluate(with: value) {
            throw PasswordLetterError()
        }
    }
}

private struct PasswordLetterError: Error, LocalizedError {
    var errorDescription: String? {
        L10n.Error.passwordLetter
    }
}
