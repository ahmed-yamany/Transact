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
    let header: String = L10n.Localizable.forgotPassword
    var title: String = L10n.Localizable.forgotPassword
    var subtitle: String = L10n.Localizable.Signup.Password.subtitle

    let passwordTitle: String = L10n.Localizable.password
    let passwordPlaceholder: String = L10n.Localizable.enterPassword
    let confirmPasswordTitle: String = L10n.Localizable.repeatPassword
    let confirmPasswordPlaceholder: String = L10n.Localizable.enterPassword
    let passwordTip: String? = L10n.Localizable.passwordTip
}
