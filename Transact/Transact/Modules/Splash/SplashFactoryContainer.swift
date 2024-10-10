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

struct SplashFactoryContainer {
    
    static func view(_ coordinator: SplashCoordinatorInterface) -> AnyView {
        SplashView(coordinator: coordinator).eraseToAnyView()
    }
    
    @MainActor
    static func coordinator() -> SplashCoordinatorInterface {
        SplashCoordinator(view: Self.view)
    }
}
