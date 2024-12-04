//
//  SignupOTPFactoryContainer.swift
//  Transact
//
//  Created by Ahmed Yamany on 30/10/2024.
//

import Coordinator
import HTTPClient
import OTP
import SwiftUI

@MainActor
struct SignupOTPFactoryContainer {
    static func client() -> HTTPClient {
        TransactFactoryContainer.client()
    }

    static func repository() -> OTPRepositoryInterFace {
        let verifyOtpService = SignupVerifyOtpService(client: Self.client())
        let resendOTPService = SignupResendOtpService(client: Self.client())
        return OTPRepository(verfyOtpService: verifyOtpService, resendOTPService: resendOTPService)
    }

    static func useCase() -> OTPUseCaseInterface {
        OTPUseCase(repository: Self.repository())
    }

    static func viewModel(_ coordinator: OTPCoordinatorInterface, _ entity: OTPViewModelEntity) -> OTPViewModel {
        OTPViewModel(entity, coordinator: coordinator, useCase: Self.useCase())
    }

    static func view(_ coordinator: OTPCoordinatorInterface, _ entity: OTPViewModelEntity) -> AnyView {
        return AnyView(
            OTPView(
                viewModel: Self.viewModel(coordinator, entity),
                content: SignupOTPContent()
            )
        )
    }

    static func coordinator(_ router: Router, signupFlow: SignupFlowInterFace, entity: OTPViewModelEntity) -> Coordinator {
        SignupOTPCoordinator(router: router, view: Self.view, signupFlow: signupFlow, entity: entity)
    }
}
