//
//  ForgotPasswordOTPViewModelEntityMapper.swift
//  Transact
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import ForgotPassword
import Foundation
import OTP

extension OTPViewModelEntity {
    init(forgotPassword: ForgotPasswordResponseEntity) {
        self.init(
            phoneNumber: forgotPassword.phoneNumber,
            otpLength: forgotPassword.otpLenght,
            otpCodeExpiresSeconds: forgotPassword.otpCodeExpiresSeconds
        )
    }
}
