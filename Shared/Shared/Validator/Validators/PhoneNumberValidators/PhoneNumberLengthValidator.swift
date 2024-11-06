//
//  PhoneNumberLengthValidator.swift
//  Shared
//
//  Created by Ahmed Yamany on 31/10/2024.
//

import Foundation
import Localization

public struct PhoneNumberLengthValidator: Validator {
    public init() {}

    public func validate(_ value: String) throws {
        if value.count != 11 {
            throw PhoneNumberLengthError()
        }
    }
}

private struct PhoneNumberLengthError: Error, LocalizedError {
    var errorDescription: String? {
        L10n.Error.phoneNumberLength
    }
}
