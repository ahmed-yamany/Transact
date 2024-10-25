//
//  LoginCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 19/10/2024.
//

import Coordinator
import Login
import SwiftUI

struct LoginCoordinator: LoginCoordinatorInterface, Coordinator {
    let router: Router
    let view: (LoginCoordinatorInterface) -> AnyView
    let authenticationFlow: AuthenticationFlowCoordinatorInterface
    
    init(
        router: Router,
        view: @escaping (LoginCoordinatorInterface) -> AnyView,
        authenticationFlow: AuthenticationFlowCoordinatorInterface
    ) {
        self.router = router
        self.view = view
        self.authenticationFlow = authenticationFlow
    }

    func start() {
        router.setView(view(self), animated: true, completion: nil)
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
