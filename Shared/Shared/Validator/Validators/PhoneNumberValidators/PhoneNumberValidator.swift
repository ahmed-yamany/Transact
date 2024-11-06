//
//  PhoneNumberValidator.swift
//  Shared
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import Foundation

public struct PhoneNumberValidator: Validator {
    public init() {}

    public func validate(_ value: String) throws {
        let validator = ValidatorChainBuilder<String>()
            .add(EmptyPhoneNumberValidator())
            .add(PhoneNumberInvalidCharachterValidator())
            .add(PhoneNumberLengthValidator())
            .build()

        try validator.validate(value)
    }
}
