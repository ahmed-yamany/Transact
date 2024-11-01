//
//  OTPUseCase.swift
//  OTP
//
//  Created by Ahmed Yamany on 30/10/2024.
//

import Foundation
import Shared

public protocol OTPUseCaseInterface {
    func validateOTP(_ otp: String, length: Int) async throws
    func verifyOTP(_ otp: String) async throws
    func resendOTP(for phoneNumber: String) async throws
}

public final actor OTPUseCase: OTPUseCaseInterface {
    let repository: OTPRepositoryInterFace

    public init(repository: OTPRepositoryInterFace) {
        self.repository = repository
    }

    public func validateOTP(_ otp: String, length: Int) async throws {
        let validator = ValidatorChainBuilder<String>()
            .add(OTPLengthValidator(length: length))
            .add(OTPInvalidCharactersValidator())
            .build()

        try validator.validate(otp)
    }

    public func verifyOTP(_ otp: String) async throws {
        try await repository.verifyOTP(otp)
    }
    
    public func resendOTP(for phoneNumber: String) async throws {
        try await repository.resendOTP(for: phoneNumber)
    }
}
