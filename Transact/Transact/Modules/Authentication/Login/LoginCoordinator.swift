//
//  LoginCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 19/10/2024.
//

import Coordinator
import Login
import SwiftUI
import DesignSystem

struct LoginCoordinator: LoginCoordinatorInterface, Coordinator {
    let router: Router
    let view: (LoginCoordinatorInterface, any AlertPresenter) -> AnyView
    let authenticationFlow: AuthenticationFlowInterface
    let alertPresenter: any AlertPresenter
    
    init(
        router: Router,
        view: @escaping (LoginCoordinatorInterface, any AlertPresenter) -> AnyView,
        authenticationFlow: AuthenticationFlowInterface,
        alertPresenter: any AlertPresenter
    ) {
        self.router = router
        self.view = view
        self.authenticationFlow = authenticationFlow
        self.alertPresenter = alertPresenter
    }

    func start() {
        router.setView(view(self, alertPresenter), animated: true, completion: nil)
    }

    func navigateToSignUp() {
        authenticationFlow.navigateToSignup()
    }

    func navigateToForgotPassword() {
        authenticationFlow.navigateToForgotPassword()
    }

    func authenticationCompleted() {
        authenticationFlow.navigateToTabBar()
    }
}
