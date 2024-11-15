//
//  SignupViewModel.swift
//  Signup
//
//  Created by Ahmed Yamany on 29/10/2024.
//

import Combine
import DesignSystem
import SwiftUI

@MainActor
public protocol SignupViewModelInterface: ObservableObject {
    var phoneNumber: String { get set }
    var fullName: String { get set }
    var phoneNumberError: PrimaryTextFieldError? { get set }
    var fullNameError: PrimaryTextFieldError? { get set }

    func shouldDisableSignupButton() -> Bool

    func loginButtonTapped()
    func signupButtonTapped()
    func forgotPasswordButtonTapped()
}

@MainActor
public final class SignupViewModel: SignupViewModelInterface {
    @Published public var phoneNumber: String = "" {
        didSet {
            if phoneNumberValidationCancellable == nil {
                bindPhoneNumberValidation()
            }
        }
    }

    @Published public var fullName: String = "" {
        didSet {
            if fullNameValidationCancellable == nil {
                bindFullNameValidation()
            }
        }
    }

    @Published public var phoneNumberError: PrimaryTextFieldError? = .error("")
    @Published public var fullNameError: PrimaryTextFieldError? = .error("")

    private var phoneNumberValidationCancellable: Cancellable?
    private var phoneNumberValidatorTask: Task<Void, Never>?

    private var fullNameValidationCancellable: Cancellable?
    private var fullNameValidatorTask: Task<Void, Never>?

    private var signupTask: Task<Void, Never>?

    private let useCase: SignupUseCaseInterface
    private let coordinator: SignupCoordinatorInterface
    private let alertPresenter: AlertPresenter

    public init(
        useCase: SignupUseCaseInterface,
        coordinator: SignupCoordinatorInterface,
        alertPresenter: AlertPresenter
    ) {
        self.useCase = useCase
        self.coordinator = coordinator
        self.alertPresenter = alertPresenter
    }

    public func loginButtonTapped() {
        coordinator.navigateToSignin()
    }

    public func forgotPasswordButtonTapped() {
        coordinator.navigateToForgtPassword()
    }

    public func signupButtonTapped() {
        signupTask?.cancel()
        signupTask = Task {
            do {
                let response: SignupResponseEntity = try await useCase.signupNewUser(phoneNumber: phoneNumber, fullName: fullName)
                coordinator.navigateToConfirmSignup(response)
            } catch {
                alertPresenter.presentAlert(.toast(.error(title: Text(error.localizedDescription))))
            }
        }
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

    private func bindFullNameValidation() {
        fullNameValidationCancellable?.cancel()
        fullNameValidationCancellable = $fullName
            .sink { [weak self] fullName in
                guard let self else { return }
                fullNameValidatorTask?.cancel()
                fullNameValidatorTask = validateFullName(fullName)
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

    private func validateFullName(_ fullName: String) -> Task<Void, Never> {
        Task {
            do {
                try await useCase.validateFullName(fullName)
                fullNameError = nil
            } catch {
                fullNameError = .error(error.localizedDescription)
            }
        }
    }

    public func shouldDisableSignupButton() -> Bool {
        phoneNumberError != nil || fullNameError != nil
    }
}
