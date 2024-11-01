//
//  SignupUseCase.swift
//  Signup
//
//  Created by Ahmed Yamany on 29/10/2024.
//

import Foundation
import Shared

public protocol SignupUseCaseInterface {
    func validatePhoneNumber(_ phoneNumber: String) async throws
    func validateFullName(_ fullName: String) async throws
}

public final actor SignupUseCase: SignupUseCaseInterface {
    public init() {
    }

    public func validatePhoneNumber(_ phoneNumber: String) async throws {
        let validator = ValidatorChainBuilder<String>()
            .add(EmptyPhoneNumberValidator())
            .add(PhoneNumberInvalidCharachterValidator())
            .add(PhoneNumberLengthValidator())
            .build()

        try validator.validate(phoneNumber)
    }

    public func validateFullName(_ fullName: String) async throws {
        let validator = ValidatorChainBuilder<String>()
            .add(FullNameLengthValidator())
            .build()
        
        try validator.validate(fullName)
    }
}
