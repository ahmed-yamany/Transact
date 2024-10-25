//
//  LoginModel.swift
//  Login
//
//  Created by Ahmed Yamany on 25/10/2024.
//

import Foundation

public struct LoginModel: Encodable {
    public let phoneNumber: String
    public let password: String

    public init(phoneNumber: String, password: String) {
        self.phoneNumber = phoneNumber
        self.password = password
    }
}
