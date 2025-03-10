//
//  SignupPasswordFactoryContainer.swift
//  Transact
//
//  Created by Ahmed Yamany on 30/10/2024.
//

import Coordinator
import Password
import Shared
import SwiftUI

@MainActor
struct SignupPasswordFactoryContainer {
    static func useCase() -> PasswordUseCaseInterface {
        let passwordValidator = AnyValidator(PasswordValidators())
        let confirmPasswordValidator = AnyValidator(ConfirmPasswordValidators())
        let client = TransactFactoryContainer.client()
        let passwordService = SignupPasswordService(client: client)

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
        AnyView(PasswordView(viewModel: Self.viewModel(coordinator), content: SignupPasswordContent()))
    }

    static func coordinator(_ router: Router, signupFlow: SignupFlowInterFace) -> Coordinator {
        SignupPasswordCoordinator(router: router, view: Self.view, signupFlow: signupFlow)
    }
}
