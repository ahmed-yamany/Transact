//
//  OnboardingCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 17/10/2024.
//

import Coordinator
import DesignSystem
import Onboarding
import SwiftUI

struct OnboardingCoordinator: OnboardingCoordinatorInterface, View {
    typealias ViewProviderType = (OnboardingCoordinatorInterface, AlertPresenter) -> AnyView

    @EnvironmentObject private var transactViewModel: TransactViewModel
    @EnvironmentObject private var alertPresenter: AlertPresenterController

    let view: ViewProviderType

    init(view: @escaping ViewProviderType) {
        self.view = view
    }

    var body: some View {
        view(self, alertPresenter)
    }

    func skipOnboarding() {
        transactViewModel.flow = .authentication
    }
}
