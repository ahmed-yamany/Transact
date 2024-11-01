//
//  ResendOTPService.swift
//  OTP
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import Foundation

public protocol ResendOTPServiceInterface {
    func resendOTP(for phoneNumber: String) async throws
}
