//
//  ValidatorChain.swift
//  Shared
//
//  Created by Ahmed Yamany on 31/10/2024.
//

import Foundation

public final class ValidatorChain<T>: Validator {
    private var validators: [AnyValidator<T>]

    public init(_ validators: [AnyValidator<T>]) {
        self.validators = validators
    }

    public func validate(_ value: T) throws {
        if let firstValidator = validators.first {
            try firstValidator.validate(value)
        }

        let remainingValidators = Array(validators.dropFirst())
        if !remainingValidators.isEmpty {
            try ValidatorChain(remainingValidators).validate(value)
        }
    }
}
