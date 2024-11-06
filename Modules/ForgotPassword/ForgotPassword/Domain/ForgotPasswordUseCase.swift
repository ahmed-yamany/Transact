//
//  ForgotPasswordUseCase.swift
//  ForgotPassword
//
//  Created by Ahmed Yamany on 29/10/2024.
//

import Foundation
import Shared

public protocol ForgotPasswordUseCaseInterface {
    func validatePhoneNumber(_ phoneNumber: String) async throws
    func forgotPassword(_ phoneNumber: String) async throws -> ForgotPasswordResponseEntity
}

public final actor ForgotPasswordUseCase: ForgotPasswordUseCaseInterface {
    private let service: ForgotPasswordServiceInterface
    private let phoneNumberValidator: AnyValidator<String>

    public init(service: ForgotPasswordServiceInterface, phoneNumberValidator: AnyValidator<String>) {
        self.service = service
        self.phoneNumberValidator = phoneNumberValidator
    }

    public func validatePhoneNumber(_ phoneNumber: String) async throws {
        try phoneNumberValidator.validate(phoneNumber)
    }

    public func forgotPassword(_ phoneNumber: String) async throws -> ForgotPasswordResponseEntity {
        let requestModel = ForgotPasswordRequestModel(phoneNumber: phoneNumber)
        let responseModel: ForgotPasswordResponseModel = try await service.forgotPassword(requestModel)
        return ForgotPasswordResponseEntity(responseModel)
    }
}
