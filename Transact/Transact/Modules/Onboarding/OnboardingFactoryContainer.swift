//
//  OnboardingFactoryContainer.swift
//  Transact
//
//  Created by Ahmed Yamany on 24/09/2024.
//

import SwiftUI
import Coordinator
import Onboarding
import SwiftUIModifiers

struct OnboardingFactoryContainer {
    
    @MainActor
    static func viewModel(_ coordinator: OnboardingCoordinatorInterface) -> OnboardingViewModel {
        OnboardingViewModel(coordinator: coordinator)
    }
    
    @MainActor
    static func view(_ coordinator: OnboardingCoordinatorInterface) -> AnyView {
        OnboardingView(viewModel: Self.viewModel(coordinator)).eraseToAnyView()
    }
    
    @MainActor
    static func coordinator(_ router: Router) -> Coordinator {
        OnboardingCoordinator(router: router, view: Self.view)
    }
}
