//
//  OnboardingCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 17/10/2024.
//

import Coordinator
import Onboarding
import SwiftUI

struct OnboardingCoordinator: OnboardingCoordinatorInterface, View {
    @EnvironmentObject private var transactViewModel: TransactViewModel

    let view: (OnboardingCoordinatorInterface) -> AnyView

    init(view: @escaping (OnboardingCoordinatorInterface) -> AnyView) {
        self.view = view
    }

    var body: some View {
        view(self)
    }

    func skipOnboarding() {
        transactViewModel.flow = .authentication
    }
}
