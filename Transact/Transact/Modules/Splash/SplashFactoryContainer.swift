//
//  SplashFactoryContainer.swift
//  Transact
//
//  Created by Ahmed Yamany on 19/09/2024.
//

import SwiftUI
import Splash
import Coordinator

struct SplashFactoryContainer {
    @MainActor
    static func view(_ coordinator: SplashCoordinatorInterface) -> AnyView {
        AnyView(SplashView(coordinator: coordinator))
    }
    
    @MainActor
    static func coordinator(router: Router) -> Coordinator {
        SplashCoordinator(router: router, view: Self.view)
    }
}
