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
    let view: (OTPCoordinatorInterface) -> AnyView
    let signupFlow: SignupFlowInterFace

    init(router: Router, view: @escaping (OTPCoordinatorInterface) -> AnyView, signupFlow: SignupFlowInterFace) {
        self.router = router
        self.view = view
        self.signupFlow = signupFlow
    }

    func start() {
        router.push(view(self), animated: true, completion: nil)
    }

    func navigateToUpdatePassword() {
        signupFlow.navigateToUpdatePassword()
    }
}
