//
//  SplashCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 19/09/2024.
//

import SwiftUI
import Splash
import Coordinator

struct SplashCoordinator: SplashCoordinatorInterface, Coordinator {
    let id = UUID()
    
    let view: (SplashCoordinatorInterface) -> AnyView
    let router: Router
    
    init(router: Router, view: @escaping (SplashCoordinatorInterface) -> AnyView) {
        self.view = view
        self.router = router
    }
    
    func start() {
        router.push(view(self), animated: true, completion: nil)
    }
    
    func splashViewEnded() {
        SplashFactoryContainer.coordinator(router: router).start()
    }
}
