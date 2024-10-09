//
//  TransactCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 17/09/2024.
//

import SwiftUI
import Coordinator
import SwiftUIViews
import DesignSystem

protocol TransactCoordinatorProtocol: Coordinator {
    
}

class TransactCoordinator: TransactCoordinatorProtocol {

    let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
//        SplashFactoryContainer.coordinator(router).start()
    }
}
