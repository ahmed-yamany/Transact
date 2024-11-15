//
//  TransactFactoryContainer.swift
//  Transact
//
//  Created by Ahmed Yamany on 14/10/2024.
//

import Coordinator
import DesignSystem
import Foundation
import HTTPClient
import URLSessionHTTPClient

@MainActor
struct TransactFactoryContainer {
    static func client() -> HTTPClient {
        URLSessionHTTPClient(session: .shared, enableLogger: true)
    }

    static func viewModel() -> TransactViewModel {
        TransactViewModel()
    }

    static func router() -> NavigationStackRouter {
        NavigationStackRouter()
    }

    static func alertPresenter() -> AlertPresenterController {
        AlertPresenterController()
    }
}
