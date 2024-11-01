//
//  ForgotPasswordCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 29/10/2024.
//

import Coordinator
import ForgotPassword
import SwiftUI

final class ForgotPasswordCoordinator: Coordinator, ForgotPasswordCoordinatorInterface {
    let router: Router
    let view: (ForgotPasswordCoordinatorInterface) -> AnyView
    let authenticationFlow: AuthenticationFlowInterface

    init(
        router: Router,
        view: @escaping (ForgotPasswordCoordinatorInterface) -> AnyView,
        authenticationFlow: AuthenticationFlowInterface
    ) {
        self.router = router
        self.view = view
        self.authenticationFlow = authenticationFlow
    }

    func start() {
        router.push(view(self), animated: true, completion: nil)
    }
}
