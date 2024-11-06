//
//  ForgotPasswordOTPFactoryContainer.swift
//  Transact
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import Coordinator
import ForgotPassword
import HTTPClient
import OTP
import SwiftUI
import URLSessionHTTPClient

@MainActor
struct ForgotPasswordOTPFactoryContainer {
    static func client() -> HTTPClient {
        TransactFactoryContainer.client()
    }

    static func repository() -> OTPRepositoryInterFace {
        let verifyOtpService = ForgotPasswordVerifyOtpService(client: Self.client())
        let resendOTPService = ForgotPasswordResendOtpService(client: Self.client())
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

    static func coordinator(
        _ router: Router,
        forgotPasswordFlow: ForgotPasswordFlowInterface,
        entity: OTPViewModelEntity
    ) -> Coordinator {
        ForgotPasswordOTPCoordinator(router: router, view: Self.view, forgotPasswordFlow: forgotPasswordFlow, entity: entity)
    }
}
