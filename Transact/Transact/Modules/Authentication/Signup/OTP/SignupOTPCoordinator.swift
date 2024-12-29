//
//  SignupOTPCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 30/10/2024.
//

import Coordinator
import OTP
import SwiftUI

struct SignupOTPCoordinator: Coordinator, OTPCoordinatorInterface {
    let router: Router
    let view: (OTPCoordinatorInterface, OTPViewModelEntity) -> AnyView
    let signupFlow: SignupFlowInterFace
    let entity: OTPViewModelEntity

    init(
        router: Router,
        view: @escaping (OTPCoordinatorInterface, OTPViewModelEntity) -> AnyView,
        signupFlow: SignupFlowInterFace,
        entity: OTPViewModelEntity
    ) {
        self.router = router
        self.view = view
        self.signupFlow = signupFlow
        self.entity = entity
    }

    func start() {
        let view = AnyHashableView(view(self, entity))
        router.push(view, animated: true, completion: nil)
    }

    func navigateToUpdatePassword() {
        signupFlow.navigateToUpdatePassword()
    }
}
