//
//  CoordinatorRouter.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 09/08/2024.
//

import SwiftUI

@MainActor
public final class NavigationControllerRouter: Router {
    public let navigationController: UINavigationController
    public let navigationRouter: NavigationControllerManager
    public let presentationRouter: PresentationRouter

    public init(
        navigationController: UINavigationController,
        navigationRouter: NavigationControllerManager,
        presentationRouter: PresentationRouter
    ) {
        self.navigationController = navigationController
        self.navigationRouter = navigationRouter
        self.presentationRouter = presentationRouter
    }

    public func push(_ view: some View, animated: Bool, completion: (() -> Void)?) {
        let viewController = UIHostingController(rootView: view)
        navigationRouter.push(viewController, animated: animated, completion: completion ?? {})
    }

    public func push(contentsOf viewsToAppend: [some View], animated: Bool, completion: (() -> Void)?) {
        navigationRouter.push(
            contentsOf: viewsToAppend.map { UIHostingController(rootView: $0) },
            animated: animated,
            completion: completion ?? {})
    }

    public func setView(_ view: some View, animated: Bool, completion: (() -> Void)?) {
        setViews([view], animated: animated, completion: completion ?? {})
    }

    public func setViews(_ views: [some View], animated: Bool, completion: (() -> Void)?) {
        let viewControllers = views.map { UIHostingController(rootView: $0) }
        navigationRouter.setViewControllers(viewControllers, animated: animated, completion: completion ?? {})
    }

    public func replaceLastView(with view: some View, animated: Bool, completion: (() -> Void)?) {
        navigationRouter.replaceLastViewController(with: UIHostingController(rootView: view), animated: animated, completion: completion ?? {})
    }

    public func replaceFirstView(with view: some View, animated: Bool, completion: (() -> Void)?) {
        navigationRouter.replaceFirstViewController(with: UIHostingController(rootView: view), animated: animated, completion: completion ?? {})
    }

    public func insert(_ view: some View, at index: Int, animated: Bool, completion: (() -> Void)?) {
        navigationRouter.insert(UIHostingController(rootView: view), at: index, animated: animated, completion: completion ?? {})
    }

    public func insert(contentsOfViews viewsToInsert: [some View], at index: Int, animated: Bool, completion: (() -> Void)?) {
        let viewControllers = viewsToInsert.map { UIHostingController(rootView: $0) }
        navigationRouter.insert(contentsOfViewControllers: viewControllers, at: index, animated: animated, completion: completion ?? {})
    }

    public func pop(animated: Bool, completion: (() -> Void)?) {
        navigationRouter.pop(animated: animated, completion: completion ?? {})
    }

    public func popToRoot(animated: Bool, completion: (() -> Void)?) {
        navigationRouter.popToRoot(animated: animated, completion: completion ?? {})
    }

    public func present(
        _ view: some View,
        animated: Bool,
        presentationStyle: UIModalPresentationStyle,
        transitionStyle: UIModalTransitionStyle,
        completion: (() -> Void)?
    ) {
        let viewController = UIHostingController(rootView: view)
        
        presentationRouter.present(
            viewController,
            animated: animated,
            presentationStyle: presentationStyle,
            transitionStyle: transitionStyle,
            completion: completion ?? {}
        )
    }

    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        presentationRouter.dismiss(animated: animated, completion: completion ?? {})
    }
    
    public func popToView<T: View>(ofType type: T.Type, animated: Bool, completion: (() -> Void)?) {
        
    }
}
