//
//  SignupResponseModel.swift
//  Signup
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import Foundation

public struct SignupResponseModel: Decodable {
    public let phoneNumber: String
    public let otpCodeExpiresSeconds: Int
    public let otpLenght: Int

    public init(phoneNumber: String, otpCodeExpiresSeconds: Int, otpLenght: Int) {
        self.phoneNumber = phoneNumber
        self.otpCodeExpiresSeconds = otpCodeExpiresSeconds
        self.otpLenght = otpLenght
    }

    enum CodingKeys: String, CodingKey {
        case phoneNumber = "phone_number"
        case otpCodeExpiresSeconds = "otp_code_expires_seconds"
        case otpLenght = "otp_lenght"
    }
}
