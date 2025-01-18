//
//  LoginCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 19/10/2024.
//

import Coordinator
import DesignSystem
import Login
import SwiftUI

struct LoginCoordinator: LoginCoordinatorInterface, Coordinator, View {
    let router: Router
    let view: (LoginCoordinatorInterface, any AlertPresenter) -> AnyView
    let authenticationFlow: AuthenticationFlowInterface
    @EnvironmentObject var alertPresenter: AlertPresenterController

    init(
        router: Router,
        view: @escaping (LoginCoordinatorInterface, any AlertPresenter) -> AnyView,
        authenticationFlow: AuthenticationFlowInterface
    ) {
        self.router = router
        self.view = view
        self.authenticationFlow = authenticationFlow
    }

    var body: some View {
        view(self, alertPresenter)
    }

    func start() {
        router.setView(AnyHashableView(self), animated: true, completion: nil)
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
