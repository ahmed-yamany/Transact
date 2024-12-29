//
//  SignupPasswordCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 30/10/2024.
//

import Coordinator
import Password
import SwiftUI

struct SignupPasswordCoordinator: Coordinator, PasswordCoordinatorInterface {
    let router: Router
    let view: (PasswordCoordinatorInterface) -> AnyView
    let signupFlow: SignupFlowInterFace

    init(router: Router, view: @escaping (PasswordCoordinatorInterface) -> AnyView, signupFlow: SignupFlowInterFace) {
        self.router = router
        self.view = view
        self.signupFlow = signupFlow
    }

    func start() {
        let view = AnyHashableView(view(self))
        router.push(view, animated: true, completion: nil)
    }

    func navigateToSignin() {
        signupFlow.navigateToSignin()
    }
}
