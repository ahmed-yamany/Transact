//
//  SignupFactoryContainer.swift
//  Transact
//
//  Created by Ahmed Yamany on 29/10/2024.
//

import Coordinator
import DesignSystem
import Shared
import Signup
import SwiftUI
import URLSessionHTTPClient

@MainActor
struct SignupFactoryContainer {
    static func service() -> SignupServiceInterface {
        let client = TransactFactoryContainer.client()
        return SignupService(client: client)
    }

    static func useCase() -> SignupUseCaseInterface {
        let phoneNumberValidator = AnyValidator(PhoneNumberValidator())
        return SignupUseCase(
            service: Self.service(),
            phoneNumberValidator: phoneNumberValidator
        )
    }

    static func viewModel(_ coordinator: SignupCoordinatorInterface, alertPresenter: AlertPresenter) -> SignupViewModel {
        SignupViewModel(
            useCase: Self.useCase(),
            coordinator: coordinator,
            alertPresenter: alertPresenter
        )
    }

    static func view(_ coordinator: SignupCoordinatorInterface, alertPresenter: AlertPresenter) -> AnyView {
        AnyView(SignupView(viewModel: Self.viewModel(coordinator, alertPresenter: alertPresenter)))
    }

    static func coordinator(_ router: Router, authenticationFlow: AuthenticationFlowInterface, alertPresenter: AlertPresenter) -> Coordinator {
        SignupCoordinator(router: router, view: Self.view, authenticationFlow: authenticationFlow, alertPresenter: alertPresenter)
    }
}
