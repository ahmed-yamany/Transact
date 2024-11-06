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
}
