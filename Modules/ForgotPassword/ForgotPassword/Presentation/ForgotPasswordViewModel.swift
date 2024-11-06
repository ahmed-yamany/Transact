//
//  ForgotPasswordViewModel.swift
//  ForgotPassword
//
//  Created by Ahmed Yamany on 29/10/2024.
//

import Combine
import DesignSystem
import SwiftUI

@MainActor
public protocol ForgotPasswordViewModelInterface: ObservableObject {
    var phoneNumber: String { get set }
    var phoneNumberError: PrimaryTextFieldError? { get set }

    func shouldDisableSignupButton() -> Bool

    func changePasswordButtonTapped()
}

public final class ForgotPasswordViewModel: ForgotPasswordViewModelInterface {
    @Published public var phoneNumber: String = "" {
        didSet {
            if phoneNumberValidationCancellable == nil {
                bindPhoneNumberValidation()
            }
        }
    }

    @Published public var phoneNumberError: PrimaryTextFieldError? = .error("")

    private var phoneNumberValidationCancellable: Cancellable?
    private var phoneNumberValidatorTask: Task<Void, Never>?
    private var forgotPasswordTask: Task<Void, Never>?

    private let useCase: ForgotPasswordUseCaseInterface
    private let coordinator: ForgotPasswordCoordinatorInterface

    public init(useCase: ForgotPasswordUseCaseInterface, coordinator: ForgotPasswordCoordinatorInterface) {
        self.useCase = useCase
        self.coordinator = coordinator
    }

    public func changePasswordButtonTapped() {
        forgotPasswordTask?.cancel()
        forgotPasswordTask = Task {
            do {
                let responseEntity: ForgotPasswordResponseEntity = try await useCase.forgotPassword(phoneNumber)
                coordinator.navigateToConfirmForgotPassword(responseEntity)
            } catch {
            }
        }
    }

    public func shouldDisableSignupButton() -> Bool {
        phoneNumberError != nil
    }

    private func bindPhoneNumberValidation() {
        phoneNumberValidationCancellable?.cancel()
        phoneNumberValidationCancellable = $phoneNumber
            .sink { [weak self] phoneNumber in
                guard let self else { return }
                phoneNumberValidatorTask?.cancel()
                phoneNumberValidatorTask = validatePhoneNumber(phoneNumber)
            }
    }

    private func validatePhoneNumber(_ phoneNumber: String) -> Task<Void, Never> {
        Task {
            do {
                try await useCase.validatePhoneNumber(phoneNumber)
                phoneNumberError = nil
            } catch {
                phoneNumberError = .error(error.localizedDescription)
            }
        }
    }
}
