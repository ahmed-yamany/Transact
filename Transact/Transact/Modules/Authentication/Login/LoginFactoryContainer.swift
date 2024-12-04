//
//  LoginFactoryContainer.swift
//  Transact
//
//  Created by Ahmed Yamany on 19/10/2024.
//

import Coordinator
import DesignSystem
import Login
import SwiftUI
import HTTPClient

@MainActor
struct LoginFactoryContainer {
    static func service() -> LoginServiceInterface {
        let client = TransactFactoryContainer.client()
        return LoginService(client: client)
    }

    static func useCase() -> LoginUseCaseInterface {
        LoginUseCase(service: Self.service())
    }

    static func viewModel(_ coordinator: LoginCoordinatorInterface, alertPresenter: any AlertPresenter) -> LoginViewModel {
        LoginViewModel(coordinator: coordinator, useCase: Self.useCase(), alertPresenter: alertPresenter)
    }

    static func view(_ coordinator: LoginCoordinatorInterface, _ alertPresenter: any AlertPresenter) -> AnyView {
        AnyView(LoginView(viewModel: Self.viewModel(coordinator, alertPresenter: alertPresenter)))
    }

    static func coordinator(
        _ router: Router,
        authenticationFlow: AuthenticationFlowInterface,
        alertPresenter: any AlertPresenter
    ) -> Coordinator {
        LoginCoordinator(router: router, view: Self.view, authenticationFlow: authenticationFlow, alertPresenter: alertPresenter)
    }
}
