//
//  LoginViewModel.swift
//  Login
//
//  Created by Ahmed Yamany on 19/10/2024.
//

import Combine
import DesignSystem
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
    let alertPresenter: any AlertPresenter

    public init(
        coordinator: LoginCoordinatorInterface,
        useCase: LoginUseCaseInterface,
        alertPresenter: any AlertPresenter
    ) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.alertPresenter = alertPresenter
    }

    public func loginButtonTapped() {
        
        alertPresenter.presentAlert(.toast(.error(title: Text("Hello"), message: Text("Error Occured"))))
//        
//        Task {
//            try? await Task.sleep(for: .seconds(1))
//            let item = ToastAlertItem(title: Text("Ahemd"))
//            alertPresenter.presentAlert(.toast(item))
//        }
        
//        Task {
//            do {
//                let model = LoginModel(phoneNumber: phoneNumber, password: password)
//                try await useCase.login(model)
//                coordinator.authenticationCompleted()
//            } catch {
//                let alert = AlertItem(title: Text(""), primaryButton: { [weak self] in
//                    self?.alertPresenter.dissmisAlert()
//                })
//                alertPresenter.presentAlert(alert)
//            }
//        }
    }

    public func signupButtonTapped() {
        coordinator.navigateToSignUp()
    }

    public func forgotPasswordButtonTapped() {
        coordinator.navigateToForgotPassword()
    }
}

