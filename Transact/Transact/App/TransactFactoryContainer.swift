//
//  TransactFactoryContainer.swift
//  Transact
//
//  Created by Ahmed Yamany on 17/09/2024.
//

import Coordinator
import NavigationRouter
import UIKit

final class TransactFactoryContainer {
    // this could be a custom navigation controller
    private static func navigationController() -> UINavigationController {
        UINavigationController()
    }

    // this could be a custom navigation router
    @MainActor
    private static func navigationRouter(_ navigationController: UINavigationController) -> NavigationRouter {
        NavigationRouter(navigationController: navigationController)
    }

    // also this could be a custom presentation router
    @MainActor
    private static func presentationRouter(_ rootViewController: UIViewController) -> PresentationRouter {
        PresentationRouter(rootViewController: rootViewController)
    }

    @MainActor
    static func router() -> Router {
        let navigationController = navigationController()
        return CoordinatorRouter(
            navigationController: navigationController,
            navigationRouter: navigationRouter(navigationController),
            presentationRouter: presentationRouter(navigationController)
        )
    }

    @MainActor
    static var appCoordinator: TransactCoordinatorProtocol = TransactCoordinator(router: router())
    
    @MainActor
    static func refreshAppCoordinator() -> TransactCoordinatorProtocol {
        Self.appCoordinator = TransactCoordinator(router: router())
        return Self.appCoordinator
    }
}
