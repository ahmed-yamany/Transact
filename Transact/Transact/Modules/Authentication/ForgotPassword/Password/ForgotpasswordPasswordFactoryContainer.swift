//
//  ForgotpasswordPasswordFactoryContainer.swift
//  Transact
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import Coordinator
import Password
import Shared
import SwiftUI

@MainActor
struct ForgotpasswordPasswordFactoryContainer {
    static func useCase() -> PasswordUseCaseInterface {
        let passwordValidator = AnyValidator(PasswordValidators())
        let confirmPasswordValidator = AnyValidator(ConfirmPasswordValidators())
        let client = TransactFactoryContainer.client()
        let passwordService = ForgotpasswordPasswordService(client: client)

        return PasswordUseCase(
            passwordValidator: passwordValidator,
            confirmPasswordValidator: confirmPasswordValidator,
            passwordService: passwordService
        )
    }

    static func viewModel(_ coordinator: PasswordCoordinatorInterface) -> PasswordViewModel {
        PasswordViewModel(coordinator: coordinator, useCase: Self.useCase())
    }

    static func view(_ coordinator: PasswordCoordinatorInterface) -> AnyView {
        AnyView(PasswordView(viewModel: Self.viewModel(coordinator), content: ForgotpasswordPasswordContent()))
    }

    static func coordinator(_ router: Router, forgotPasswordFlow: ForgotPasswordFlowInterface) -> Coordinator {
        ForgotpasswordPasswordCoordinator(router: router, view: Self.view, forgotPasswordFlow: forgotPasswordFlow)
    }
}
