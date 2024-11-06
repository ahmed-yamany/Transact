//
//  ForgotPasswordVerifyOtpService.swift
//  Transact
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import Foundation
import HTTPClient
import OTP

struct ForgotPasswordVerifyOtpService: VerifyOtpServiceInterface {
    let client: HTTPClient

    func verifyOTP(_ otp: String) async throws {
    }
}
