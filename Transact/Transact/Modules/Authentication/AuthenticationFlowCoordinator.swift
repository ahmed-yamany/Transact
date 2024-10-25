//
//  AuthenticationFlowCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 17/10/2024.
//

import Coordinator
import SwiftUI

protocol AuthenticationFlowCoordinatorInterface {
    func navigateToLogin()
    func navigateToSignup()
    func navigateToForgotPassword()
    func navigateToTabBar()
}

struct AuthenticationFlowCoordinator: AuthenticationFlowCoordinatorInterface, View {
    @StateObject var router = TransactFactoryContainer.router()

    var body: some View {
        RoutableNavigationStack(router: router)
            .onAppear {
                navigateToLogin()
            }
    }

    func navigateToLogin() {
        LoginFactoryContainer.coordinator(router, authenticationFlow: self).start()
    }

    func navigateToSignup() {
    }

    func navigateToForgotPassword() {
    }

    func navigateToTabBar() {
    }
}
