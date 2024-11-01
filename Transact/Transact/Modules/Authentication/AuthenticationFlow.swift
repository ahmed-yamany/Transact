//
//  AuthenticationFlowCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 17/10/2024.
//

import Coordinator
import SwiftUI

protocol AuthenticationFlowInterface {
    func navigateToLogin()
    func navigateToSignup()
    func navigateToForgotPassword()
    func navigateToTabBar()
}

struct AuthenticationFlow: AuthenticationFlowInterface, View {
    @StateObject var router = TransactFactoryContainer.router()

    let transactCoordinator: TransactCoordinatorInterface

    init(transactCoordinator: TransactCoordinatorInterface) {
        self.transactCoordinator = transactCoordinator
    }

    var body: some View {
        RoutableNavigationStack(router: router)
            .onAppear {
                navigateToLogin()
            }
            .animation(.easeInOut(duration: 1), value: router.rootView)
    }

    func navigateToLogin() {
        LoginFactoryContainer.coordinator(router, authenticationFlow: self).start()
    }

    func navigateToSignup() {
        SignupFactoryContainer.coordinator(router, authenticationFlow: self).start()
    }

    func navigateToForgotPassword() {
        ForgotPasswordFactoryContainer.coordinator(router, authenticationFlow: self).start()
    }

    func navigateToTabBar() {
        transactCoordinator.checkAuthentication()
    }
}
