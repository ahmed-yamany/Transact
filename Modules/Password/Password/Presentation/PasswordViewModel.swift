//
//  PasswordViewModel.swift
//  OTP
//
//  Created by Ahmed Yamany on 30/10/2024.
//

import Combine
import SwiftUI

@MainActor
public protocol PasswordViewModelInterface: ObservableObject {
}

@MainActor
public final class PasswordViewModel: PasswordViewModelInterface {
    private let coordinator: PasswordCoordinatorInterface
    private let useCase: PasswordUseCaseInterface

    public init(coordinator: PasswordCoordinatorInterface, useCase: PasswordUseCaseInterface) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
}
