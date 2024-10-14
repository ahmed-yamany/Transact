//
//  TransactFactoryContainer.swift
//  Transact
//
//  Created by Ahmed Yamany on 14/10/2024.
//

import Foundation
import Coordinator

struct TransactFactoryContainer {
    @MainActor
    static func router() -> NavigationStackRouter {
        NavigationStackRouter()
    }
}
