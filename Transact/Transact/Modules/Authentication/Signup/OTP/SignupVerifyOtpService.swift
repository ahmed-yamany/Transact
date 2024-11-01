//
//  SignupVerifyOtpService.swift
//  Transact
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import Foundation
import OTP
import HTTPClient

struct SignupVerifyOtpService: VerifyOtpServiceInterface {
    let client: HTTPClient
    
    func verifyOTP(_ otp: String) async throws {
    }
}
