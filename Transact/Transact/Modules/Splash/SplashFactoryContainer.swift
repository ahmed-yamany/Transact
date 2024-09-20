//
//  SplashFactoryContainer.swift
//  Transact
//
//  Created by Ahmed Yamany on 19/09/2024.
//

import SwiftUI
import Coordinator
import Splash
import SwiftUIModifiers
import DesignSystem

struct SplashFactoryContainer {
    
    static func view(_ coordinator: SplashCoordinatorInterface) -> AnyView {
        SplashView(coordinator: coordinator).eraseToAnyView()
    }
    
    @MainActor
    static func coordinator(_ router: Router) -> Coordinator {
        SplashCoordinator(router: router, view: Self.view)
    }
}
