//
//  ForgotPasswordCoordinator.swift
//  ForgotPassword
//
//  Created by Ahmed Yamany on 29/10/2024.
//

import Foundation

public protocol ForgotPasswordCoordinatorInterface {
    func navigateToConfirmForgotPassword(_ entity: ForgotPasswordResponseEntity)
}
