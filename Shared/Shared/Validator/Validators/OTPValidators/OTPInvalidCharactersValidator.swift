//
//  OTPInvalidCharactersValidator.swift
//  Shared
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import Foundation
import Localization

public struct OTPInvalidCharactersValidator: Validator {
    public init() {}

    public func validate(_ value: String) throws {
        if Int(value) == nil {
            throw OTPInvalidCharactersError()
        }
    }
}

struct OTPInvalidCharactersError: Error, LocalizedError {
    var errorDescription: String? {
        L10n.Error.otpInvalidCharacters
    }
}
