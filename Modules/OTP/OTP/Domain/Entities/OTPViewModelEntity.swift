//
//  OTPViewModelEntity.swift
//  OTP
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import Foundation

public struct OTPViewModelEntity {
    public let phoneNumber: String
    public let otpLength: Int
    public let otpCodeExpiresSeconds: Int

    public init(phoneNumber: String, otpLength: Int, otpCodeExpiresSeconds: Int) {
        self.phoneNumber = phoneNumber
        self.otpLength = otpLength
        self.otpCodeExpiresSeconds = otpCodeExpiresSeconds
    }
}
