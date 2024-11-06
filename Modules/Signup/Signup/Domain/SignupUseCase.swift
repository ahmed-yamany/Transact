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
    func signupNewUser(phoneNumber: String, fullName: String) async throws -> SignupResponseEntity
}

public final actor SignupUseCase: SignupUseCaseInterface {
    private let service: SignupServiceInterface
    private let phoneNumberValidator: AnyValidator<String>

    public init(service: SignupServiceInterface, phoneNumberValidator: AnyValidator<String>) {
        self.service = service
        self.phoneNumberValidator = phoneNumberValidator
    }

    public func validatePhoneNumber(_ phoneNumber: String) async throws {
        try phoneNumberValidator.validate(phoneNumber)
    }

    public func validateFullName(_ fullName: String) async throws {
        let validator = ValidatorChainBuilder<String>()
            .add(FullNameLengthValidator())
            .build()

        try validator.validate(fullName)
    }

    public func signupNewUser(phoneNumber: String, fullName: String) async throws -> SignupResponseEntity {
        let requestModel = SignupRequestModel(phoneNumber: phoneNumber, fullName: fullName)
        let responseModel: SignupResponseModel = try await service.signup(requestModel)
        return SignupResponseEntity(responseModel)
    }
}
