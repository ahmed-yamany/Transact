//
//  OnboardingViewModel.swift
//  Onboarding
//
//  Created by Ahmed Yamany on 17/10/2024.
//

import Combine
import DesignSystem
import Localization
import SwiftUI

@MainActor
public protocol OnboardingViewModelInterface: ObservableObject {
    var models: [OnboardingEntity] { get set }
    var selectedIndex: Int { get set }

    func loadModels()

    func getModel(at index: Int) -> OnboardingEntity
    func skipOrRestartButtonTapped()
    func nextButtonTapped()
    func backButtonTapped()
    func getStartedButtonTapped()

    func skipOrRestartButtonTitle() -> String
    func shouldShowGetStartedButton() -> Bool
    func shouldDisableBackButton() -> Bool
}

@MainActor
public final class OnboardingViewModel: OnboardingViewModelInterface {
    @Published public var models: [OnboardingEntity] = []
    @Published public var selectedIndex: Int = 0

    internal let coordinator: OnboardingCoordinatorInterface
    internal let useCase: OnboardingUseCaseInterface
    internal let alertPresenter: AlertPresenter

    public init(
        coordinator: OnboardingCoordinatorInterface,
        useCase: OnboardingUseCaseInterface,
        alertPresenter: AlertPresenter
    ) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.alertPresenter = alertPresenter
    }

    public func loadModels() {
        Task {
            do {
                models = try await useCase.getOnboardingModels()
            } catch {
                let alertItem = OnboardingErrorVariableAlertItem(
                    message: "error.localizedDescription",
                    realoadAction: { [weak self] in
                        self?.loadModels()
                    }
                )
                alertPresenter.presentAlert(.variable(alertItem))
            }
        }
    }

    public func getModel(at index: Int) -> OnboardingEntity {
        models[index]
    }

    public func skipOrRestartButtonTapped() {
        if isIndexAtLast() {
            selectedIndex = 0
        } else {
            coordinator.skipOnboarding()
        }
    }

    public func nextButtonTapped() {
        selectedIndex += 1
    }

    public func backButtonTapped() {
        selectedIndex -= 1
    }

    public func getStartedButtonTapped() {
        coordinator.skipOnboarding()
    }

    public func skipOrRestartButtonTitle() -> String {
        isIndexAtLast() ? L10n.restart : L10n.skip
    }

    public func shouldShowGetStartedButton() -> Bool {
        !isIndexAtLast()
    }

    public func shouldDisableBackButton() -> Bool {
        selectedIndex == 0
    }

    private func isIndexAtLast() -> Bool {
        selectedIndex == models.count - 1
    }
}
