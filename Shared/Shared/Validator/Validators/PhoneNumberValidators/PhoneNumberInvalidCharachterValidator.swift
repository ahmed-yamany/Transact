//
//  PhoneNumberInvalidCharachterValidator.swift
//  Shared
//
//  Created by Ahmed Yamany on 31/10/2024.
//

import Foundation
import Localization

public struct PhoneNumberInvalidCharachterValidator: Validator {
    public init() {}

    public func validate(_ value: String) throws {
        if Int(value) == nil {
            throw PhoneNumberInvalidCharachterError()
        }
    }
}

struct PhoneNumberInvalidCharachterError: Error, LocalizedError {
    var errorDescription: String? {
        L10n.Error.phoneNumberInvalidCharachters
    }
}
