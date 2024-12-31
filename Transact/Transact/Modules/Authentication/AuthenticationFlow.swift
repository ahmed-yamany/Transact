//
//  AuthenticationFlowCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 17/10/2024.
//

import Coordinator
import DesignSystem
import SwiftUI

protocol AuthenticationFlowInterface {
    func navigateToLogin()
    func navigateToSignup()
    func navigateToForgotPassword()
    func navigateToTabBar()
}

struct AuthenticationFlow: AuthenticationFlowInterface, View {
    @StateObject var router = TransactFactoryContainer.router()
    @EnvironmentObject var alertPresenter: AlertPresenterController
//    @StateObject var router = navigationControllerRouter()

    let transactCoordinator: TransactCoordinatorInterface

    init(transactCoordinator: TransactCoordinatorInterface) {
        self.transactCoordinator = transactCoordinator
    }

    var body: some View {
//        RoutableNavigationController(router: router)

        RoutableNavigationStack(router: router)
            .onAppear {
                navigateToLogin()
            }
//            .animation(.easeInOut(duration: 0.5), value: router.rootView)
    }

    func navigateToLogin() {
        LoginFactoryContainer.coordinator(router, authenticationFlow: self, alertPresenter: alertPresenter).start()
    }

    func navigateToSignup() {
        SignupFactoryContainer.coordinator(router, authenticationFlow: self, alertPresenter: alertPresenter).start()
    }

    func navigateToForgotPassword() {
        ForgotPasswordFactoryContainer.coordinator(router, authenticationFlow: self, alertPresenter: alertPresenter).start()
    }

    func navigateToTabBar() {
        transactCoordinator.checkAuthentication()
    }
}

extension NavigationControllerRouter: ObservableObject {}

@MainActor
func navigationControllerRouter() -> NavigationControllerRouter {
    let nvController = UINavigationController()
    return NavigationControllerRouter(
        navigationController: nvController
    )
}
