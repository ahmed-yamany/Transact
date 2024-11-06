//
//  PasswordValidators.swift
//  Shared
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import Foundation

public struct PasswordValidators: Validator {
    public init() {}

    public func validate(_ value: String) throws {
        let validator = ValidatorChainBuilder<String>()
            .add(PasswordLengthValidator())
            .add(PasswordLetterValidator())
            .add(PasswordNumberValidator())
            .add(PasswordSpecialCharacterValidator())
            .build()

        try validator.validate(value)
    }
}
