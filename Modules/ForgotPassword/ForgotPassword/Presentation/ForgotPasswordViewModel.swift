//
//  ForgotPasswordViewModel.swift
//  ForgotPassword
//
//  Created by Ahmed Yamany on 29/10/2024.
//

import Combine
import SwiftUI

@MainActor
public protocol ForgotPasswordViewModelInterface: ObservableObject {
}

public final class ForgotPasswordViewModel: ForgotPasswordViewModelInterface {
    private let useCase: ForgotPasswordUseCaseInterface
    private let coordinator: ForgotPasswordCoordinatorInterface

    public init(useCase: ForgotPasswordUseCaseInterface, coordinator: ForgotPasswordCoordinatorInterface) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
}
