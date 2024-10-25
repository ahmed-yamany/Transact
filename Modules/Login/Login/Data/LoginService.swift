//
//  LoginService.swift
//  Login
//
//  Created by Ahmed Yamany on 25/10/2024.
//

import Foundation

public protocol LoginServiceInterface {
    func login(_ model: LoginModel) async throws
}
