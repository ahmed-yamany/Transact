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

struct TransactCoordinator<ViewModel: TransactViewModelInterface>: TransactCoordinatorInterface, View {
    @ObservedObject var languageSettings = LocalizationSettings.shared
    @ObservedObject var viewModel: ViewModel
    @StateObject var alertPresenter = AlertPresenterController()

    init(viewModel: ViewModel) {
        _viewModel = ObservedObject(wrappedValue: viewModel)
    }

    var body: some View {
        GeometryReader { geometryReader in
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
            .overlay {
                ToastAlertPresenterView(
                    alertPresenter,
                    safeAreaInsets: geometryReader.safeAreaInsets,
                    rect: geometryReader.frame(in: .global)
                )
            }
        }
    }

    func checkAuthentication() {
        viewModel.checkAuthentication()
    }
}
