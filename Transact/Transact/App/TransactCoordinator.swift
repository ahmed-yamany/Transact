//
//  TransactCoordinator.swift
//  Transact
//
//  Created by Ahmed Yamany on 17/09/2024.
//

import Foundation
import Coordinator

protocol TransactCoordinatorProtocol: Coordinator {
    
}

class TransactCoordinator: TransactCoordinatorProtocol {
    let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        
    }
}
