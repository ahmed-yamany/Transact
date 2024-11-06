//
//  PasswordUseCase.swift
//  OTP
//
//  Created by Ahmed Yamany on 30/10/2024.
//

import Foundation
import Shared

public protocol PasswordUseCaseInterface {
    func validatePassword(_ password: String) async throws
    func validateConfirmPassword(_ confirmPassword: String, with password: String) async throws
    func updatePassword(_ password: String) async throws
}

public final actor PasswordUseCase: PasswordUseCaseInterface {
    private let passwordValidator: AnyValidator<String>
    private let confirmPasswordValidator: AnyValidator<PasswordMatch>
    private let passwordService: PasswordServiceInterface

    public init(
        passwordValidator: AnyValidator<String>,
        confirmPasswordValidator: AnyValidator<PasswordMatch>,
        passwordService: PasswordServiceInterface
    ) {
        self.passwordValidator = passwordValidator
        self.confirmPasswordValidator = confirmPasswordValidator
        self.passwordService = passwordService
    }

    public func validatePassword(_ password: String) async throws {
        try passwordValidator.validate(password)
    }

    public func validateConfirmPassword(_ confirmPassword: String, with password: String) async throws {
        try confirmPasswordValidator.validate(.init(password: password, confirmPassword: confirmPassword))
    }

    public func updatePassword(_ password: String) async throws {
        try await passwordService.updatePassword(password)
    }
}
