//
//  SignupCoordinator.swift
//  Signup
//
//  Created by Ahmed Yamany on 29/10/2024.
//

import Foundation

public protocol SignupCoordinatorInterface {
    func navigateToConfirmSignup(_ entity: SignupResponseEntity)
    func navigateToSignin()
    func navigateToForgtPassword()
}
