//
//  SignupResponseEntity.swift
//  Signup
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import Foundation

public struct SignupResponseEntity {
    public let phoneNumber: String
    public let otpCodeExpiresSeconds: Int
    public let otpLenght: Int

    public init(phoneNumber: String, otpCodeExpiresSeconds: Int, otpLenght: Int) {
        self.phoneNumber = phoneNumber
        self.otpCodeExpiresSeconds = otpCodeExpiresSeconds
        self.otpLenght = otpLenght
    }
}

public extension SignupResponseEntity {
    init(_ model: SignupResponseModel) {
        phoneNumber = model.phoneNumber
        otpCodeExpiresSeconds = model.otpCodeExpiresSeconds
        otpLenght = model.otpLenght
    }
}
