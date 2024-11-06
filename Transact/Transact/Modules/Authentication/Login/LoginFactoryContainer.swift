//
//  LoginFactoryContainer.swift
//  Transact
//
//  Created by Ahmed Yamany on 19/10/2024.
//

import Coordinator
import Login
import SwiftUI
import URLSessionHTTPClient

struct LoginFactoryContainer {
    static func service() -> LoginServiceInterface {
        let client = TransactFactoryContainer.client()
        return LoginService(client: client)
    }

    static func useCase() -> LoginUseCaseInterface {
        LoginUseCase(service: Self.service())
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
    static func coordinator(_ router: Router, authenticationFlow: AuthenticationFlowInterface) -> Coordinator {
        LoginCoordinator(router: router, view: Self.view, authenticationFlow: authenticationFlow)
    }
}
