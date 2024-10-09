//
//  SplashCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 19/09/2024.
//

import SwiftUI
import Coordinator
import Splash

class SplashCoordinator: SplashCoordinatorInterface, Coordinator {
    var router: Router
    let view: (SplashCoordinatorInterface) -> AnyView
    
    init(router: Router, view: @escaping (SplashCoordinatorInterface) -> AnyView) {
        self.router = router
        self.view = view
    }
    
    func start() {
        router.setView(view(self), animated: false, completion: {})
    }
    
    func splashViewEnded() {
//        OnboardingFactoryContainer.coordinator(router).start()
    }
}
