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

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func push(_ view: AnyHashableView, animated: Bool, completion: (() -> Void)?) {
        let viewController = UIHashableHostingController(rootView: view)
        UIView.performWithTransaction({
            navigationController.pushViewController(viewController, animated: animated)
        }, completion: completion)
    }

    public func push(contentsOf viewsToAppend: [AnyHashableView], animated: Bool, completion: (() -> Void)?) {
        let viewControllers = navigationController.viewControllers
        let viewControllersToAppend = viewsToAppend.map { UIHashableHostingController(rootView: $0) }
        setViewControllers(viewControllers + viewControllersToAppend, animated: animated, completion: completion)
    }

    public func setView(_ view: AnyHashableView, animated: Bool, completion: (() -> Void)?) {
        setViews([view], animated: animated, completion: completion)
    }

    public func setViews(_ views: [AnyHashableView], animated: Bool, completion: (() -> Void)?) {
        let viewControllers = views.map { UIHashableHostingController(rootView: $0) }
        setViewControllers(viewControllers, animated: animated, completion: completion)
    }

    private func setViewControllers(_ viewControllers: [UIViewController], animated: Bool, completion: (() -> Void)?) {
        UIView.performWithTransaction({
            navigationController.setViewControllers(viewControllers, animated: animated)
        }, completion: completion)
    }

    public func replaceView(at index: Int, with view: AnyHashableView, animated: Bool, completion: (() -> Void)?) {
        let viewController = UIHashableHostingController(rootView: view)
        let viewControllers = navigationController.viewControllers.replacedElement(at: index, with: viewController)
        setViewControllers(viewControllers, animated: animated, completion: completion)
    }

    public func replaceLastView(with view: AnyHashableView, animated: Bool, completion: (() -> Void)?) {
        replaceView(at: navigationController.viewControllers.endIndex, with: view, animated: animated, completion: completion)
    }

    public func replaceFirstView(with view: AnyHashableView, animated: Bool, completion: (() -> Void)?) {
        replaceView(at: 0, with: view, animated: animated, completion: completion)
    }

    public func insert(_ view: AnyHashableView, at index: Int, animated: Bool, completion: (() -> Void)?) {
//        navigationRouter.insert(UIHashableHostingController(rootView: view), at: index, animated: animated, completion: completion ?? {})
    }

    public func insert(contentsOfViews viewsToInsert: [AnyHashableView], at index: Int, animated: Bool, completion: (() -> Void)?) {
//        let viewControllers = viewsToInsert.map { UIHashableHostingController(rootView: $0) }
//        navigationRouter.insert(contentsOfViewControllers: viewControllers, at: index, animated: animated, completion: completion ?? {})
    }

    public func pop(animated: Bool, completion: (() -> Void)?) {
//        navigationRouter.pop(animated: animated, completion: completion ?? {})
    }

    public func popToRoot(animated: Bool, completion: (() -> Void)?) {
//        navigationRouter.popToRoot(animated: animated, completion: completion ?? {})
    }

    public func present(
        _ view: AnyHashableView,
        animated: Bool,
        presentationStyle: UIModalPresentationStyle,
        transitionStyle: UIModalTransitionStyle,
        completion: (() -> Void)?
    ) {
//        let viewController = UIHashableHostingController(rootView: view)
//
//        presentationRouter.present(
//            viewController,
//            animated: animated,
//            presentationStyle: presentationStyle,
//            transitionStyle: transitionStyle,
//            completion: completion ?? {}
//        )
    }

    public func dismiss(animated: Bool, completion: (() -> Void)?) {
//        presentationRouter.dismiss(animated: animated, completion: completion ?? {})
    }

    public func popToView<T: View>(withType type: T.Type, animated: Bool, completion: (() -> Void)?) {
//        let stack = navigationRouter.viewControllers.compactMap { $0 as? UIHashableHostingController }
//        if let index = stack.firstIndex(where: { $0.type == type}) {
//            navigationRouter.popToViewController(navigationController.viewControllers[index], animated: animated, completion: completion ?? {})
//        }
    }
}
