//
//  OnboardingCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 24/09/2024.
//

import SwiftUI
import Coordinator
import Onboarding
import Orbit

class OnboardingCoordinator: OnboardingCoordinatorInterface, Coordinator {
    var router: Router
    let view: (OnboardingCoordinatorInterface) -> AnyView
    
    init(router: Router, view: @escaping (OnboardingCoordinatorInterface) -> AnyView) {
        self.router = router
        self.view = view
    }
    
    func start() {
        router.setView(view(self), animated: false, completion: {})
        HapticsProvider.sendHapticFeedback(.selection)
    }
  
}
