//
//  LoginFactoryContainer.swift
//  Transact
//
//  Created by Ahmed Yamany on 19/10/2024.
//

import Coordinator
import Login
import SwiftUI

struct LoginFactoryContainer {
    static func useCase() -> LoginUseCaseInterface {
        LoginUseCase(service: LoginService())
    }

    @MainActor
    static func viewModel(_ coordinator: LoginCoordinatorInterface) -> LoginViewModel {
        LoginViewModel(coordinator: coordinator, useCase: Self.useCase())
    }

    @MainActor
    static func view(_ coordinator: LoginCoordinatorInterface) -> AnyView {
        AnyView(LoginView(viewModel: Self.viewModel(coordinator)))
    }

    @MainActor
    static func coordinator(_ router: Router, authenticationFlow: AuthenticationFlowCoordinatorInterface) -> Coordinator {
        LoginCoordinator(router: router, view: Self.view, authenticationFlow: authenticationFlow)
    }
}
