//
//  TransactCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 17/09/2024.
//

import Coordinator
import DesignSystem
import Localization
import SwiftUI

struct TransactCoordinator<ViewModel: TransactViewModelInterface>: View {
    @ObservedObject var languageSettings = LocalizationSettings.shared
    @ObservedObject var viewModel: ViewModel

    init(viewModel: ViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        Group {
            switch viewModel.flow {
            case .splash:
                SplashFactoryContainer.coordinator {
                    viewModel.checkAuthentication()
                }
            case .onboarding:
                OnboardingFactoryContainer.coordinator()
            case .authentication:
                AuthenticationFlowCoordinator()
            case .tabBar:
                TabBarFlowCoordinator()
            }
        }
        .tint(DesignSystem.Tokens.Colors.tint)
        .configureLanguageSettings(languageSettings)
        .environmentObject(viewModel)
    }
}
