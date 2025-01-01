//
//  SignupPasswordContent.swift
//  Transact
//
//  Created by Ahmed Yamany on 31/10/2024.
//

import Foundation
import Localization
import Password

struct SignupPasswordContent: PasswordContentInterFace {
    let header: String = L10n.Localizable.signup
    let title: String = L10n.Localizable.Signup.Password.title
    let subtitle: String = L10n.Localizable.Signup.Password.subtitle

    let passwordTitle: String = L10n.Localizable.password
    let passwordPlaceholder: String = L10n.Localizable.enterPassword
    let confirmPasswordTitle: String = L10n.Localizable.repeatPassword
    let confirmPasswordPlaceholder: String = L10n.Localizable.enterPassword
    let passwordTip: String? = L10n.Localizable.passwordTip
}
