//
//  VerifyOTPService.swift
//  OTP
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import Foundation

public protocol VerifyOtpServiceInterface {
    func verifyOTP(_ otp: String) async throws
}
