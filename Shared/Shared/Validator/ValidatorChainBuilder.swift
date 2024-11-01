//
//  ValidatorChainBuilder.swift
//  Shared
//
//  Created by Ahmed Yamany on 31/10/2024.
//

import Foundation

public class ValidatorChainBuilder<T> {
    private var validators: [AnyValidator<T>] = []

    public init() { }

    public func add<U: Validator>(_ validator: U) -> Self where U.T == T {
        validators.append(AnyValidator(validator))
        return self
    }

    public func build() -> ValidatorChain<T> {
        return ValidatorChain(validators)
    }
}
