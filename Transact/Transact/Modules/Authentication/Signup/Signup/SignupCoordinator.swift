//
//  SignupCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 29/10/2024.
//

import Coordinator
import DesignSystem
import OTP
import Signup
import SwiftUI

protocol SignupFlowInterFace {
    func navigateToUpdatePassword()
    func navigateToSignin()
}

struct SignupCoordinator: Coordinator, SignupCoordinatorInterface, SignupFlowInterFace {
    let router: Router
    let view: (SignupCoordinatorInterface, AlertPresenter) -> AnyView
    let authenticationFlow: AuthenticationFlowInterface
    let alertPresenter: AlertPresenter

    init(
        router: Router,
        view: @escaping (SignupCoordinatorInterface, AlertPresenter) -> AnyView,
        authenticationFlow: AuthenticationFlowInterface,
        alertPresenter: AlertPresenter
    ) {
        self.router = router
        self.view = view
        self.authenticationFlow = authenticationFlow
        self.alertPresenter = alertPresenter
    }

    func start() {
        router.setView(view(self, alertPresenter), animated: true, completion: nil)
    }

    func navigateToConfirmSignup(_ entity: SignupResponseEntity) {
        let otpEntity = OTPViewModelEntity(signup: entity)
        SignupOTPFactoryContainer.coordinator(router, signupFlow: self, entity: otpEntity).start()
    }

    func navigateToUpdatePassword() {
        SignupPasswordFactoryContainer.coordinator(router, signupFlow: self).start()
    }

    func navigateToSignin() {
        authenticationFlow.navigateToLogin()
    }

    func navigateToForgtPassword() {
        authenticationFlow.navigateToForgotPassword()
    }
}
