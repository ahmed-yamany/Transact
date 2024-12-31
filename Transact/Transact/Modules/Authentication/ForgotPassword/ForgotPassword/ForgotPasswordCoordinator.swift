//
//  ForgotPasswordCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 29/10/2024.
//

import Coordinator
import DesignSystem
import ForgotPassword
import Login
import OTP
import SwiftUI

protocol ForgotPasswordFlowInterface {
    func navigateToUpdatePassword()
    func navigateToSignin()
}

typealias ForgotPasswordViewType = ForgotPasswordView<ForgotPasswordViewModel>

final class ForgotPasswordCoordinator: Coordinator, ForgotPasswordCoordinatorInterface, ForgotPasswordFlowInterface {
    let router: Router
    let view: (ForgotPasswordCoordinatorInterface, AlertPresenter) -> ForgotPasswordViewType
    let authenticationFlow: AuthenticationFlowInterface
    let alertPresenter: AlertPresenter

    init(
        router: Router,
        view: @escaping (ForgotPasswordCoordinatorInterface, AlertPresenter) -> ForgotPasswordViewType,
        authenticationFlow: AuthenticationFlowInterface,
        alertPresenter: AlertPresenter
    ) {
        self.router = router
        self.view = view
        self.authenticationFlow = authenticationFlow
        self.alertPresenter = alertPresenter
    }

    func start() {
        let view = AnyHashableView(view(self, alertPresenter))
        router.push(view, animated: true, completion: nil)
//        router.setBackButtonImage(UIImage())
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
