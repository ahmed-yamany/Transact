//
//  ForgotPasswordFactoryContainer.swift
//  Transact
//
//  Created by Ahmed Yamany on 29/10/2024.
//

import Coordinator
import ForgotPassword
import Shared
import SwiftUI

struct ForgotPasswordFactoryContainer {
    static func useCase() -> ForgotPasswordUseCaseInterface {
        let client = TransactFactoryContainer.client()
        let service = ForgotPasswordService(client: client)
        let phoneNumberValidator = AnyValidator(PhoneNumberValidator())
        return ForgotPasswordUseCase(service: service, phoneNumberValidator: phoneNumberValidator)
    }

    @MainActor
    static func viewModel(_ coordinator: ForgotPasswordCoordinatorInterface) -> ForgotPasswordViewModel {
        ForgotPasswordViewModel(useCase: Self.useCase(), coordinator: coordinator)
    }

    @MainActor
    static func view(_ coordinator: ForgotPasswordCoordinatorInterface) -> AnyView {
        AnyView(ForgotPasswordView(viewModel: Self.viewModel(coordinator)))
    }

    @MainActor
    static func coordinator(_ router: Router, authenticationFlow: AuthenticationFlowInterface) -> Coordinator {
        ForgotPasswordCoordinator(router: router, view: Self.view, authenticationFlow: authenticationFlow)
    }
}
