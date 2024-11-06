//
//  OTPViewModelEntityMapper.swift
//  Transact
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import Foundation
import OTP
import Signup

extension OTPViewModelEntity {
    init(signup: SignupResponseEntity) {
        self.init(
            phoneNumber: signup.phoneNumber,
            otpLength: signup.otpLenght,
            otpCodeExpiresSeconds: signup.otpCodeExpiresSeconds
        )
    }
}
