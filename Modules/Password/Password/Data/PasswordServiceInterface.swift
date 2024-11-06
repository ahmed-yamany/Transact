//
//  PasswordServiceInterface.swift
//  Password
//
//  Created by Ahmed Yamany on 07/11/2024.
//

import Foundation

public protocol PasswordServiceInterface {
    func updatePassword(_ password: String) async throws
}
