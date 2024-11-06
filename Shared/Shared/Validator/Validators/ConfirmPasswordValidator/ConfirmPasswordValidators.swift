//
//  ConfirmPasswordValidators.swift
//  Shared
//
//  Created by Ahmed Yamany on 06/11/2024.
//

import Foundation

public struct ConfirmPasswordValidators: Validator {
    public init() {}

    public func validate(_ value: PasswordMatch) throws {
        let validator = ValidatorChainBuilder()
            .add(PasswordMatchValidator())
            .build()

        try validator.validate(value)
    }
}
