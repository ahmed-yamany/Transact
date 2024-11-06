//
//  ForgotpasswordPasswordContent.swift
//  Transact
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import Foundation
import Localization
import Password

struct ForgotpasswordPasswordContent: PasswordContentInterFace {
    let header: String = L10n.forgotPassword
    var title: String = L10n.forgotPassword
    var subtitle: String = L10n.Signup.Password.subtitle

    let passwordTitle: String = L10n.password
    let passwordPlaceholder: String = L10n.enterPassword
    let confirmPasswordTitle: String = L10n.repeatPassword
    let confirmPasswordPlaceholder: String = L10n.enterPassword
    let passwordTip: String? = L10n.passwordTip
}
