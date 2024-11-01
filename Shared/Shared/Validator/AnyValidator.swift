//
//  AnyValidator.swift
//  Shared
//
//  Created by Ahmed Yamany on 31/10/2024.
//

import Foundation

public final class AnyValidator<T>: Validator {
    private let _validate: (T) throws -> Void

    public init<U: Validator>(_ validator: U) where U.T == T {
        _validate = validator.validate
    }

    public func validate(_ value: T) throws {
        try _validate(value)
    }
}
