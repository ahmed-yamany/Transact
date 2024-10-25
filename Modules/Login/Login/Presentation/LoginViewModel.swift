//
//  LoginViewModel.swift
//  Login
//
//  Created by Ahmed Yamany on 19/10/2024.
//

import Combine
import SwiftUI

@MainActor
public protocol LoginViewModelInterface: ObservableObject {
    var phoneNumber: String { get set }
    var password: String { get set }
    var rememberMe: Bool { get set }

    func loginButtonTapped()
    func signupButtonTapped()
    func forgotPasswordButtonTapped()
}

@MainActor
public final class LoginViewModel: LoginViewModelInterface {
    @Published public var phoneNumber: String = ""
    @Published public var password: String = ""
    @Published public var rememberMe: Bool = false

    public let coordinator: LoginCoordinatorInterface
    private let useCase: LoginUseCaseInterface

    public init(coordinator: LoginCoordinatorInterface, useCase: LoginUseCaseInterface) {
        self.coordinator = coordinator
        self.useCase = useCase
    }

    public func loginButtonTapped() {
        Task {
            do {
                let model = LoginModel(phoneNumber: phoneNumber, password: password)
                try await useCase.login(model)
                coordinator.authenticationCompleted()
            } catch {
                
            }
        }
    }

    public func signupButtonTapped() {
        coordinator.navigateToSignUp()
    }

    public func forgotPasswordButtonTapped() {
        coordinator.navigateToForgotPassword()
    }
}
