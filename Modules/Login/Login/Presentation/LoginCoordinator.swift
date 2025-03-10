//
//  LoginCoordinator.swift
//  Login
//
//  Created by Ahmed Yamany on 19/10/2024.
//

import Foundation

public protocol LoginCoordinatorInterface {
    func navigateToForgotPassword()
    func navigateToSignUp()
    func authenticationCompleted()
}
