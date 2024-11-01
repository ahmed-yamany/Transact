//
//  FullNameLengthValidator.swift
//  Shared
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import Foundation
import Localization

public struct FullNameLengthValidator: Validator {
    public init() {}

    public func validate(_ value: String) throws {
        if value.count < 3 {
            throw FullNameLengthError()
        }
    }
}

struct FullNameLengthError: Error, LocalizedError {
    var errorDescription: String? {
        L10n.Error.fullNameLength
    }
}
