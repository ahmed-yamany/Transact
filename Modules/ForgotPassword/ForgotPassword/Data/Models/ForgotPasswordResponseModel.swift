//
//  ForgotPasswordResponseModel.swift
//  ForgotPassword
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import Foundation

public struct ForgotPasswordResponseModel: Decodable {
    public let phoneNumber: String
    public let otpCodeExpiresSeconds: Int
    public let otpLenght: Int

    enum CodingKeys: String, CodingKey {
        case phoneNumber = "phone_number"
        case otpCodeExpiresSeconds = "otp_code_expires_seconds"
        case otpLenght = "otp_lenght"
    }
}

public extension ForgotPasswordResponseModel {
    init(phoneNumber: String, otpCodeExpires: Int, otpLenght: Int) {
        self.phoneNumber = phoneNumber
        self.otpCodeExpiresSeconds = otpCodeExpires
        self.otpLenght = otpLenght
    }
}
