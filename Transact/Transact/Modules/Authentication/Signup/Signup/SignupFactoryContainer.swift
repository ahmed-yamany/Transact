//
//  SignupFactoryContainer.swift
//  Transact
//
//  Created by Ahmed Yamany on 29/10/2024.
//

import Coordinator
import Signup
import SwiftUI

struct SignupFactoryContainer {
    static func useCase() -> SignupUseCaseInterface {
        SignupUseCase()
    }

    @MainActor
    static func viewModel(_ coordinator: SignupCoordinatorInterface) -> SignupViewModel {
        SignupViewModel(useCase: Self.useCase(), coordinator: coordinator)
    }

    @MainActor
    static func view(_ coordinator: SignupCoordinatorInterface) -> AnyView {
        AnyView(SignupView(viewModel: Self.viewModel(coordinator)))
    }

    @MainActor
    static func coordinator(_ router: Router, authenticationFlow: AuthenticationFlowInterface) -> Coordinator {
        SignupCoordinator(router: router, view: Self.view, authenticationFlow: authenticationFlow)
    }
}
