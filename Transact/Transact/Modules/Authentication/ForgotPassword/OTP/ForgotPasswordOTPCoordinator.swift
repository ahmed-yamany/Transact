//
//  ForgotPasswordOTPCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import Coordinator
import OTP
import SwiftUI

struct ForgotPasswordOTPCoordinator: Coordinator, OTPCoordinatorInterface {
    let router: Router
    let view: (OTPCoordinatorInterface, OTPViewModelEntity) -> AnyView
    let forgotPasswordFlow: ForgotPasswordFlowInterface
    let entity: OTPViewModelEntity

    init(
        router: Router,
        view: @escaping (OTPCoordinatorInterface, OTPViewModelEntity) -> AnyView,
        forgotPasswordFlow: ForgotPasswordFlowInterface,
        entity: OTPViewModelEntity
    ) {
        self.router = router
        self.view = view
        self.forgotPasswordFlow = forgotPasswordFlow
        self.entity = entity
    }

    func start() {
        router.push(view(self, entity), animated: true, completion: nil)
    }

    func navigateToUpdatePassword() {
        forgotPasswordFlow.navigateToUpdatePassword()
    }
}
