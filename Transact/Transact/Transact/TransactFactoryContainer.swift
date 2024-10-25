//
//  TransactFactoryContainer.swift
//  Transact
//
//  Created by Ahmed Yamany on 14/10/2024.
//

import Coordinator
import Foundation

struct TransactFactoryContainer {
    @MainActor
    static func viewModel() -> TransactViewModel {
        TransactViewModel()
    }

    @MainActor
    static func router() -> NavigationStackRouter {
        NavigationStackRouter()
    }
}
