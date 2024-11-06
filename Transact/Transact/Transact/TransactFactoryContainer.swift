//
//  TransactFactoryContainer.swift
//  Transact
//
//  Created by Ahmed Yamany on 14/10/2024.
//

import Coordinator
import Foundation
import HTTPClient
import URLSessionHTTPClient

struct TransactFactoryContainer {
    static func client() -> HTTPClient {
        URLSessionHTTPClient(session: .shared, enableLogger: true)
    }

    @MainActor
    static func viewModel() -> TransactViewModel {
        TransactViewModel()
    }

    @MainActor
    static func router() -> NavigationStackRouter {
        NavigationStackRouter()
    }
}
