//
//  SignupViewModel.swift
//  Signup
//
//  Created by Ahmed Yamany on 29/10/2024.
//

import SwiftUI

@MainActor
public protocol SignupViewModelInterface: ObservableObject {
}

@MainActor
public final class SignupViewModel: SignupViewModelInterface {
    private let useCase: SignupUseCaseInterface
    private let coordinator: SignupCoordinatorInterface

    public init(useCase: SignupUseCaseInterface, coordinator: SignupCoordinatorInterface) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
}
