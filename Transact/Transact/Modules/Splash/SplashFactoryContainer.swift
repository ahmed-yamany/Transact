//
//  SplashFactoryContainer.swift
//  Transact
//
//  Created by Ahmed Yamany on 19/09/2024.
//

import Coordinator
import Splash
import SwiftUI

struct SplashFactoryContainer {
    @MainActor
    static func view(_ coordinator: SplashCoordinatorInterface) -> AnyView {
        AnyView(SplashView(coordinator: coordinator))
    }

    @MainActor
    static func coordinator(splashEnded: @escaping () -> Void) -> SplashCoordinator {
        SplashCoordinator(splashEnded: splashEnded, view: Self.view)
    }
}
