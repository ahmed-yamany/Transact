//
//  SplashCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 19/09/2024.
//

import SwiftUI
import Splash

struct SplashCoordinator: SplashCoordinatorInterface, View {
    let view: (SplashCoordinatorInterface) -> AnyView
    
    init(view: @escaping (SplashCoordinatorInterface) -> AnyView) {
        self.view = view
    }
    
    var body: some View {
        view(self)
    }
    
    func start() {
        
    }
    
    func splashViewEnded() {
//        OnboardingFactoryContainer.coordinator(router).start()
    }
}
