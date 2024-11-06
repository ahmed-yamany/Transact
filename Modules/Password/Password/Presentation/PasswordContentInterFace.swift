//
//  PasswordContentInterFace.swift
//  Password
//
//  Created by Ahmed Yamany on 31/10/2024.
//

import Foundation

public protocol PasswordContentInterFace {
    var header: String { get }
    var title: String { get }
    var subtitle: String { get }

    var passwordTitle: String { get }
    var passwordPlaceholder: String { get }
    var confirmPasswordTitle: String { get }
    var confirmPasswordPlaceholder: String { get }
    var passwordTip: String? { get }
}
