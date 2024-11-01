//
//  OTPViewModel.swift
//  OTP
//
//  Created by Ahmed Yamany on 30/10/2024.
//

import Combine
import SwiftUI

@MainActor
public protocol OTPViewModelInterface: ObservableObject {
    var otp: String { get set }
    var otpLength: Int { get set }
    
    func resendButtonTapped()
    func verifyButtonTapped()
}

@MainActor
public final class OTPViewModel: OTPViewModelInterface {
    @Published public var otp: String = ""
    @Published public var otpLength: Int = 4

    private let coordinator: OTPCoordinatorInterface
    private let useCase: OTPUseCaseInterface

    public init(coordinator: OTPCoordinatorInterface, useCase: OTPUseCaseInterface) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
    
    public func resendButtonTapped() {
        
    }
    
    public func verifyButtonTapped() {
        coordinator.navigateToUpdatePassword()
    }
}
