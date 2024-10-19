//
//  OnboardingFactoryContainer.swift
//  Transact
//
//  Created by Ahmed Yamany on 17/10/2024.
//

import Coordinator
import Onboarding
import SwiftUI

struct OnboardingFactoryContainer {
    static func service() -> OnboardingServiceInterface {
        OnboardingService()
    }

    static func useCase() -> OnboardingUseCaseInterface {
        OnboardingUseCase(service: Self.service())
    }

    @MainActor
    static func viewModel(_ coordinator: OnboardingCoordinatorInterface) -> OnboardingViewModel {
        OnboardingViewModel(coordinator: coordinator, useCase: Self.useCase())
    }

    @MainActor
    static func view(_ coordinator: OnboardingCoordinatorInterface) -> AnyView {
        AnyView(OnboardingView(viewModel: Self.viewModel(coordinator)))
    }

    @MainActor
    static func coordinator() -> OnboardingCoordinator {
        OnboardingCoordinator(view: Self.view)
    }
}
