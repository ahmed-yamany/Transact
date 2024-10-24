//
//  LoginFactoryContainer.swift
//  Transact
//
//  Created by Ahmed Yamany on 19/10/2024.
//

import Coordinator
import SwiftUI
import Login

struct LoginFactoryContainer {
    @MainActor
    static func viewModel(_ coordinator: LoginCoordinatorInterface) -> LoginViewModel {
        LoginViewModel(coordinator: coordinator)
    }
    
    @MainActor
    static func view(_ coordinator: LoginCoordinatorInterface) -> AnyView {
        AnyView(LoginView(viewModel: Self.viewModel(coordinator)))
    }
    
    @MainActor
    static func coordinator(_ router: Router) -> Coordinator {
        LoginCoordinator(router: router, view: Self.view)
    }
}
