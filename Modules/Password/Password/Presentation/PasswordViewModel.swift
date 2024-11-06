//
//  PasswordViewModel.swift
//  OTP
//
//  Created by Ahmed Yamany on 30/10/2024.
//

import Combine
import DesignSystem
import Localization
import SwiftUI

@MainActor
public protocol PasswordViewModelInterface: ObservableObject {
    var password: String { get set }
    var confirmPassword: String { get set }

    var passwordError: (any PrimaryTextFieldError)? { get set }
    var confirmPasswordError: (any PrimaryTextFieldError)? { get set }

    func completeButtonTapped()
    func shouldDisableSignupButton() -> Bool
}

@MainActor
public final class PasswordViewModel: PasswordViewModelInterface {
    @Published public var password: String = "" {
        didSet {
            if passwordValidationCancellable == nil {
                bindPasswordValidation()
            }
        }
    }

    @Published public var confirmPassword: String = "" {
        didSet {
            if confirmPasswordCancellable == nil {
                bindConfirmPasswordValidation()
            }
        }
    }

    @Published public var passwordError: (any PrimaryTextFieldError)? = .error("")
    @Published public var confirmPasswordError: (any PrimaryTextFieldError)? = .error("")

    private var passwordValidationCancellable: Cancellable?
    private var passwordValidationTask: Task<Void, Never>?

    private var confirmPasswordCancellable: Cancellable?
    private var confirmPasswordTask: Task<Void, Never>?

    private let coordinator: PasswordCoordinatorInterface
    private let useCase: PasswordUseCaseInterface

    public init(coordinator: PasswordCoordinatorInterface, useCase: PasswordUseCaseInterface) {
        self.coordinator = coordinator
        self.useCase = useCase
    }

    public func completeButtonTapped() {
        Task {
            do {
                try await useCase.updatePassword(password)
                coordinator.navigateToSignin()
            } catch {
                
            }
        }
    }

    private func bindPasswordValidation() {
        passwordValidationCancellable?.cancel()
        passwordValidationCancellable = $password
            .sink { [weak self] password in
                guard let self else { return }
                passwordValidationTask?.cancel()
                passwordValidationTask = validatePassword(password)
            }
    }

    private func bindConfirmPasswordValidation() {
        confirmPasswordCancellable?.cancel()
        confirmPasswordCancellable = $confirmPassword
            .sink { [weak self] confirmPassword in
                guard let self else { return }
                confirmPasswordTask?.cancel()
                confirmPasswordTask = validateConfirmPassword(confirmPassword)
            }
    }

    private func validatePassword(_ password: String) -> Task<Void, Never> {
        Task {
            do {
                try await useCase.validatePassword(password)
                passwordError = .success(L10n.strongPassword)
            } catch {
                passwordError = .error(error.localizedDescription)
            }
        }
    }

    private func validateConfirmPassword(_ confirmPassword: String) -> Task<Void, Never> {
        Task {
            do {
                try await useCase.validateConfirmPassword(confirmPassword, with: password)
                confirmPasswordError = nil
                passwordError = nil
            } catch {
                confirmPasswordError = .error(error.localizedDescription)
            }
        }
    }

    public func shouldDisableSignupButton() -> Bool {
        passwordError != nil || confirmPasswordError != nil
    }
}
