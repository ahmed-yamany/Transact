//
//  SignupOTPFactoryContainer.swift
//  Transact
//
//  Created by Ahmed Yamany on 30/10/2024.
//

import Coordinator
import OTP
import SwiftUI

struct SignupOTPFactoryContainer {
    static func useCase() -> OTPUseCaseInterface {
        OTPUseCase()
    }
    
    @MainActor
    static func viewModel(_ coordinator: OTPCoordinatorInterface) -> OTPViewModel {
        OTPViewModel(coordinator: coordinator, useCase: Self.useCase())
    }
    
    @MainActor
    static func view(_ coordinator: OTPCoordinatorInterface) -> AnyView {
        AnyView(OTPView(viewModel: Self.viewModel(coordinator), content: SignupOTPContent()))
    }
    
    @MainActor
    static func coordinator(_ router: Router, signupFlow: SignupFlowInterFace) -> Coordinator {
        SignupOTPCoordinator(router: router, view: Self.view, signupFlow: signupFlow)
    }
}
