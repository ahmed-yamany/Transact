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
    var phoneNumber: String { get set }
    
    func changePasswordButtonTapped()
}

public final class ForgotPasswordViewModel: ForgotPasswordViewModelInterface {
    @Published public var phoneNumber: String = ""
    
    private let useCase: ForgotPasswordUseCaseInterface
    private let coordinator: ForgotPasswordCoordinatorInterface

    public init(useCase: ForgotPasswordUseCaseInterface, coordinator: ForgotPasswordCoordinatorInterface) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    public func changePasswordButtonTapped() {
        
    }
}
