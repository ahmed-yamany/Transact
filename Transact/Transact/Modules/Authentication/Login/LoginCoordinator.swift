//
//  LoginCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 19/10/2024.
//

import Coordinator
import Login
import SwiftUI

struct LoginCoordinator: LoginCoordinatorInterface, Coordinator {
    let router: Router
    let view: (LoginCoordinatorInterface) -> AnyView

    init(router: Router, view: @escaping (LoginCoordinatorInterface) -> AnyView) {
        self.router = router
        self.view = view
    }

    func start() {
        router.setView(view(self), animated: true, completion: nil)
    }
}
