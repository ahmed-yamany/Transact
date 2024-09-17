//
//  CoordinatorRouter.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 09/08/2024.
//

import SwiftUI
import NavigationRouter

@MainActor
public final class CoordinatorRouter: Router {
    
    public let navigationController: UINavigationController
    public let navigationRouter: NavigationRouter
    public let presentationRouter: PresentationRouter
    
    public init(
        navigationController: UINavigationController,
        navigationRouter: NavigationRouter,
        presentationRouter: PresentationRouter
    ) {
        self.navigationController = navigationController
        self.navigationRouter = navigationRouter
        self.presentationRouter = presentationRouter
    }
    
    public func push(_ view: some View, animated: Bool, completion: @escaping () -> Void) {
        let viewController = UIHostingController(rootView: view)
        navigationRouter.push(viewController, animated: animated, completion: completion)
    }
    
    public func setView(_ view: some View, animated: Bool, completion: @escaping () -> Void) {
        setViews([view], animated: animated, completion: completion)
    }
    
    public func setViews(_ views: [some View], animated: Bool, completion: @escaping () -> Void) {
        let viewControllers = views.map { UIHostingController(rootView: $0) }
        navigationRouter.setViewControllers(viewControllers, animated: animated, completion: completion)
    }
    
    public func present(
        _ view: some View,
        animated: Bool,
        presentationStyle: UIModalPresentationStyle,
        transitionStyle: UIModalTransitionStyle,
        completion: @escaping () -> Void
    ) {
        let viewController = UIHostingController(rootView: view)
        presentationRouter.present(
            viewController,
            animated: animated,
            presentationStyle: presentationStyle,
            transitionStyle: transitionStyle,
            completion: completion
        )
    }
}

