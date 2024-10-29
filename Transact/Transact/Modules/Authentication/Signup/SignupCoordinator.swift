//
//  SignupCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 29/10/2024.
//

import Coordinator
import Signup
import SwiftUI

final class SignupCoordinator: Coordinator, SignupCoordinatorInterface {
    let router: Router
    let view: (SignupCoordinatorInterface) -> AnyView
    let authenticationFlow: AuthenticationFlowCoordinatorInterface

    init(
        router: Router,
        view: @escaping (SignupCoordinatorInterface) -> AnyView,
        authenticationFlow: AuthenticationFlowCoordinatorInterface
    ) {
        self.router = router
        self.view = view
        self.authenticationFlow = authenticationFlow
    }

    func start() {
        router.setView(view(self), animated: true, completion: nil)
    }
}
