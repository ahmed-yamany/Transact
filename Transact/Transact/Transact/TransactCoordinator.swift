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

protocol TransactCoordinatorInterface {
    func checkAuthentication()
}

struct TransactCoordinator: TransactCoordinatorInterface, View {
    @ObservedObject var languageSettings = LocalizationSettings.shared
    @StateObject var viewModel = TransactFactoryContainer.viewModel()
    @StateObject var alertPresenter = TransactFactoryContainer.alertPresenter()

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
                AuthenticationFlow(transactCoordinator: self)
            case .tabBar:
                TabBarFlow()
            }
        }
        .tint(DesignSystem.Tokens.Colors.tint)
        .configureLanguageSettings(languageSettings)
        .environmentObject(viewModel)
        .environmentObject(alertPresenter)
        .toastAlertPresenter($alertPresenter.toastAlerts)
        .variableAlertPresenter($alertPresenter.variableAlert)
    }

    func checkAuthentication() {
        viewModel.checkAuthentication()
    }
}
