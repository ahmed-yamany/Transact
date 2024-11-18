//
//  OnboardingViewModelTests.swift
//  OnboardingTests
//
//  Created by Ahmed Yamany on 16/11/2024.
//

import DesignSystem
import Localization
@testable import Onboarding
import Testing
import UIKit

extension Tag {
    @Tag static var initializer: Self
}

@Suite
struct OnboardingViewModelTests {
    private let coordinator: OnboardingCoordinatorMock
    private let useCase: OnboardingUseCaseMock
    private let alertPresenter: OnboardingAlertPresenterMock
    private let sut: OnboardingViewModel

    init() async throws {
        coordinator = OnboardingCoordinatorMock()
        useCase = OnboardingUseCaseMock()
        alertPresenter = await OnboardingAlertPresenterMock()
        sut = await OnboardingViewModel(
            coordinator: coordinator,
            useCase: useCase,
            alertPresenter: alertPresenter
        )
    }

    @Test(.tags(.initializer))
    func initializer() async throws {
        _ = try await #require(sut.coordinator as? OnboardingCoordinatorMock)
        _ = try await #require(sut.useCase as? OnboardingUseCaseMock)
        _ = try await #require(sut.alertPresenter as? OnboardingAlertPresenterMock)
        await #expect(sut.models.isEmpty)
        await #expect(sut.selectedIndex == 0)
    }

    @Test
    func getStartedButtonTapped() async throws {
        await sut.getStartedButtonTapped()
        #expect(coordinator.onboardingSkiped)
    }

    @Test
    func shouldDisableBackButton() async throws {
        await sut.setSelectedIndex(0)
        await MainActor.run {
            #expect(sut.shouldDisableBackButton())
        }
    }

    @Test
    func nextButtonTapped() async {
        await sut.setSelectedIndex(0)
        await sut.nextButtonTapped()
        await sut.nextButtonTapped()
        await #expect(sut.selectedIndex == 2)

        await sut.setSelectedIndex(3)
        await sut.nextButtonTapped()
        await sut.nextButtonTapped()
        await #expect(sut.selectedIndex == 5)
    }

    @Test
    func backButtonTapped() async {
        await sut.setSelectedIndex(2)
        await sut.backButtonTapped()
        await sut.backButtonTapped()
        await #expect(sut.selectedIndex == 0)

        await sut.setSelectedIndex(10)
        await sut.backButtonTapped()
        await sut.backButtonTapped()
        await #expect(sut.selectedIndex == 8)
    }

    @Test
    func shouldShowGetStartedButton_shouldBeFalse_whenSelectedIndexIsAtLast() async throws {
        let models = try await useCase.getOnboardingModels()
        await sut.setModels(models)
        await sut.setSelectedIndexToLast()
        await MainActor.run {
            #expect(!sut.shouldShowGetStartedButton())
        }
    }

    @Test
    func shouldShowGetStartedButton_shouldBeTrue_whenSelectedIndexIsNotAtLast() async throws {
        let models = try await useCase.getOnboardingModels()
        await sut.setModels(models)
        await sut.setSelectedIndex(0)
        await MainActor.run {
            #expect(sut.shouldShowGetStartedButton())
        }
    }

    @Test
    func skipOrRestartButtonTitle_WhenSelectedIndexAtLast_ShouldReturnRestart() async throws {
        let models = try await useCase.getOnboardingModels()
        await sut.setModels(models)
        await sut.setSelectedIndexToLast()
        await #expect(sut.skipOrRestartButtonTitle() == L10n.restart)
    }
    
    @Test
    func skipOrRestartButtonTitle_WhenSelectedIndexAtNotLast_ShouldReturnSkip() async throws {
        let models = try await useCase.getOnboardingModels()
        await sut.setModels(models)
        await sut.setSelectedIndex(1)
        await #expect(sut.skipOrRestartButtonTitle() == L10n.skip)
    }
}

private class OnboardingCoordinatorMock: OnboardingCoordinatorInterface {
    var onboardingSkiped: Bool = false

    func skipOnboarding() {
        onboardingSkiped = true
    }
}

private struct OnboardingUseCaseMock: OnboardingUseCaseInterface {
    func getOnboardingModels() async throws -> [OnboardingEntity] {
        return [
            .init(image: UIImage(), description: ""),
            .init(image: UIImage(), description: ""),
            .init(image: UIImage(), description: ""),
            .init(image: UIImage(), description: ""),
        ]
    }
}

private struct OnboardingAlertPresenterMock: AlertPresenter {
    func presentAlert(_ alert: AlertType, _ completion: (() -> Void)?) {
    }
}

extension OnboardingViewModel {
    func setSelectedIndex(_ index: Int) {
        selectedIndex = index
    }

    func setModels(_ models: [OnboardingEntity]) {
        self.models = models
    }

    func setSelectedIndexToLast() {
        selectedIndex = models.count - 1
    }
}
