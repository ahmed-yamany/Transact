//
//  SignupViewModel.swift
//  Signup
//
//  Created by Ahmed Yamany on 29/10/2024.
//

import SwiftUI

@MainActor
public protocol SignupViewModelInterface: ObservableObject {
    var phoneNumber: String { get set }
    var fullName: String { get set }

    func loginButtonTapped()
    func signupButtonTapped()
    func forgotPasswordButtonTapped()
}

@MainActor
public final class SignupViewModel: SignupViewModelInterface {
    @Published public var phoneNumber: String = ""
    @Published public var fullName: String = ""

    private let useCase: SignupUseCaseInterface
    private let coordinator: SignupCoordinatorInterface

    public init(useCase: SignupUseCaseInterface, coordinator: SignupCoordinatorInterface) {
        self.useCase = useCase
        self.coordinator = coordinator
    }

    public func loginButtonTapped() {
        coordinator.navigateToSignin()
    }

    public func forgotPasswordButtonTapped() {
        coordinator.navigateToForgtPassword()
    }

    public func signupButtonTapped() {
    }
}
