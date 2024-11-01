//
//  SignupResendOtpService.swift
//  Transact
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import Foundation
import HTTPClient
import OTP

struct SignupResendOtpService: ResendOTPServiceInterface {
    let client: HTTPClient

    func resendOTP(for phoneNumber: String) async throws {
    }
}
