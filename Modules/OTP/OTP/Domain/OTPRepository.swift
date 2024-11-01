//
//  OTPRepository.swift
//  OTP
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import Foundation

public protocol OTPRepositoryInterFace {
    func verifyOTP(_ otp: String) async throws
    func resendOTP(for phoneNumber: String) async throws
}

public final actor OTPRepository: OTPRepositoryInterFace {
    private let verfyOtpService: VerifyOtpServiceInterface
    private let resendOTPService: ResendOTPServiceInterface

    public init(verfyOtpService: VerifyOtpServiceInterface, resendOTPService: ResendOTPServiceInterface) {
        self.verfyOtpService = verfyOtpService
        self.resendOTPService = resendOTPService
    }

    public func verifyOTP(_ otp: String) async throws {
        try await verfyOtpService.verifyOTP(otp)
    }
    
    public func resendOTP(for phoneNumber: String) async throws {
        try await resendOTPService.resendOTP(for: phoneNumber)
    }
}
