//
//  SplashCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 19/09/2024.
//

import SwiftUI
import Splash
import Coordinator

struct SplashCoordinator: SplashCoordinatorInterface, RoutableView, Coordinator {
    let id = UUID()
    
    let view: (SplashCoordinatorInterface) -> AnyView
    let router: Router
    
    init(router: Router, view: @escaping (SplashCoordinatorInterface) -> AnyView) {
        self.view = view
        self.router = router
    }
    
    var body: some View {
        view(self)
    }
    
    func start() {
//        router.present(self, animated: true, presentationStyle: .automatic, transitionStyle: .coverVertical, completion: {})
        router.push(self, animated: true, completion: {})
    }
    
    func splashViewEnded() {
        SplashFactoryContainer.coordinator(router: router).start()
    }
    
    static func == (lhs: SplashCoordinator, rhs: SplashCoordinator) -> Bool {
        lhs.id == rhs.id
    }
}
