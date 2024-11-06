//
//  ForgotPasswordCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 29/10/2024.
//

import Coordinator
import ForgotPassword
import OTP
import SwiftUI

protocol ForgotPasswordFlowInterface {
    func navigateToUpdatePassword()
    func navigateToSignin()
}

final class ForgotPasswordCoordinator: Coordinator, ForgotPasswordCoordinatorInterface, ForgotPasswordFlowInterface {
    let router: Router
    let view: (ForgotPasswordCoordinatorInterface) -> AnyView
    let authenticationFlow: AuthenticationFlowInterface

    init(
        router: Router,
        view: @escaping (ForgotPasswordCoordinatorInterface) -> AnyView,
        authenticationFlow: AuthenticationFlowInterface
    ) {
        self.router = router
        self.view = view
        self.authenticationFlow = authenticationFlow
    }

    func start() {
        router.push(view(self), animated: true, completion: nil)
    }

    func navigateToConfirmForgotPassword(_ entity: ForgotPasswordResponseEntity) {
        let entity = OTPViewModelEntity(forgotPassword: entity)
        ForgotPasswordOTPFactoryContainer.coordinator(router, forgotPasswordFlow: self, entity: entity).start()
    }

    func navigateToUpdatePassword() {
        ForgotpasswordPasswordFactoryContainer.coordinator(router, forgotPasswordFlow: self).start()
    }

    func navigateToSignin() {
        authenticationFlow.navigateToLogin()
    }
}
