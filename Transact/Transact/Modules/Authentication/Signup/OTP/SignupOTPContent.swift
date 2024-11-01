//
//  SignupOTPContent.swift
//  Transact
//
//  Created by Ahmed Yamany on 31/10/2024.
//

import Foundation
import OTP
import Localization

struct SignupOTPContent: OTPContentInterFace {
    let header: String = L10n.signup
    let title: String = L10n.Signup.Otp.title
    let subtitle: String = L10n.Signup.Otp.subtitle("+234 810 000000", "02:59")
}
