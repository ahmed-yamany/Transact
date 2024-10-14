//
//  SplashFactoryContainer.swift
//  Transact
//
//  Created by Ahmed Yamany on 19/09/2024.
//

import SwiftUI
import Splash
import SwiftUIModifiers
import Coordinator

struct SplashFactoryContainer {
    @MainActor
    static func view(_ coordinator: SplashCoordinatorInterface) -> AnyView {
        SplashView(coordinator: coordinator).eraseToAnyView()
    }
    
    @MainActor
    static func coordinator(router: Router) -> Coordinator {
        SplashCoordinator(router: router, view: Self.view)
    }
}
