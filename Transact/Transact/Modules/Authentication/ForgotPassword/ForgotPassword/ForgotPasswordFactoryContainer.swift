//
//  ForgotPasswordFactoryContainer.swift
//  Transact
//
//  Created by Ahmed Yamany on 29/10/2024.
//

import Coordinator
import DesignSystem
import ForgotPassword
import Shared
import SwiftUI

@MainActor
struct ForgotPasswordFactoryContainer {
    static func useCase() -> ForgotPasswordUseCaseInterface {
        let client = TransactFactoryContainer.client()
        let service = ForgotPasswordService(client: client)
        let phoneNumberValidator = AnyValidator(PhoneNumberValidator())
        return ForgotPasswordUseCase(service: service, phoneNumberValidator: phoneNumberValidator)
    }

    static func viewModel(
        _ coordinator: ForgotPasswordCoordinatorInterface,
        alertPresenter: AlertPresenter
    ) -> ForgotPasswordViewModel {
        ForgotPasswordViewModel(useCase: Self.useCase(), coordinator: coordinator, alertPresenter: alertPresenter)
    }

    static func view(
        _ coordinator: ForgotPasswordCoordinatorInterface,
        alertPresenter: AlertPresenter
    ) -> ForgotPasswordViewType {
        ForgotPasswordView(viewModel: Self.viewModel(coordinator, alertPresenter: alertPresenter))
    }

    static func coordinator(
        _ router: Router,
        authenticationFlow: AuthenticationFlowInterface,
        alertPresenter: AlertPresenter
    ) -> Coordinator {
        ForgotPasswordCoordinator(
            router: router,
            view: Self.view,
            authenticationFlow: authenticationFlow,
            alertPresenter: alertPresenter
        )
    }
}
