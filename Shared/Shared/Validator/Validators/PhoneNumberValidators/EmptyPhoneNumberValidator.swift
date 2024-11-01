//
//  EmptyPhoneNumberValidator.swift
//  Shared
//
//  Created by Ahmed Yamany on 31/10/2024.
//

import Foundation
import Localization

public struct EmptyPhoneNumberValidator: Validator {
    public init() {}

    public func validate(_ value: String) throws {
        if value.isEmpty {
            throw EmptyPhoneNumberError()
        }
    }
}

struct EmptyPhoneNumberError: Error, LocalizedError {
    var errorDescription: String? {
        L10n.Error.emptyPhoneNumber
    }
}
