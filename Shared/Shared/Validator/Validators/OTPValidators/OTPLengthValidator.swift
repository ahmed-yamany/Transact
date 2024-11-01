//
//  OTPLengthValidator.swift
//  Shared
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import Foundation
import Localization

public struct OTPLengthValidator: Validator {
    let length: Int
    public init(length: Int) {
        self.length = length
    }

    public func validate(_ value: String) throws {
        if value.count < length {
            throw OTPLengthError(length: length)
        }
    }
}

struct OTPLengthError: Error, LocalizedError {
    let length: Int

    var errorDescription: String? {
        L10n.Error.otpLength(String(length))
    }
}
