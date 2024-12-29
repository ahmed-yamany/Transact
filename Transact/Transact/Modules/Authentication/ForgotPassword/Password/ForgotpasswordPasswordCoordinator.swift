//
//  ForgotpasswordPasswordCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 01/11/2024.
//

import Coordinator
import Password
import SwiftUI
import ForgotPassword

struct ForgotpasswordPasswordCoordinator: Coordinator, PasswordCoordinatorInterface {
    let router: Router
    let view: (PasswordCoordinatorInterface) -> AnyView
    let forgotPasswordFlow: ForgotPasswordFlowInterface

    init(
        router: Router,
        view: @escaping (PasswordCoordinatorInterface) -> AnyView,
        forgotPasswordFlow: ForgotPasswordFlowInterface
    ) {
        self.router = router
        self.view = view
        self.forgotPasswordFlow = forgotPasswordFlow
    }

    func start() {
        router.push(view(self), animated: true, completion: nil)
        
        Task {
            try? await Task.sleep(for: .seconds(2))
            router.popToView(ofType: ForgotPasswordViewType.self, animated: true, completion: nil)
        }
    }
    
    func navigateToSignin() {
        forgotPasswordFlow.navigateToSignin()
    }
}
