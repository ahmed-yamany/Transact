//
//  CoordinatorRouter.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 09/08/2024.
//

import SwiftUI
@MainActor
public protocol NavigationControllerRouterInterface: Router, ObservableObject {
    var navigationController: UINavigationController { get }
    var presentedViewControllers: [UIViewController] { get }
    var presentedViewController: UIViewController { get }
}

@MainActor
public final class NavigationControllerRouter: NavigationControllerRouterInterface {
    public var presentedViewControllers: [UIViewController] {
        var stack: [UIViewController] = []

        if var currentViewController = navigationController.presentedViewController {
            stack.append(currentViewController)
            while let nextViewController = currentViewController.presentedViewController {
                currentViewController = nextViewController
                stack.append(currentViewController)
            }
        }
        return stack
    }

    /// The top-most presented view controller.
    public var presentedViewController: UIViewController {
        guard let presentedViewController = presentedViewControllers.last else {
            return navigationController
        }

        return presentedViewController
    }

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
        replaceView(at: navigationController.viewControllers.count - 1, with: view, animated: animated, completion: completion)
    }

    public func replaceFirstView(with view: AnyHashableView, animated: Bool, completion: (() -> Void)?) {
        replaceView(at: 0, with: view, animated: animated, completion: completion)
    }

    public func insert(_ view: AnyHashableView, at index: Int, animated: Bool, completion: (() -> Void)?) {
        insert(contentsOfViews: [view], at: index, animated: animated, completion: completion)
    }

    public func insert(contentsOfViews viewsToInsert: [AnyHashableView], at index: Int, animated: Bool, completion: (() -> Void)?) {
        let viewControllerToInsert = viewsToInsert.map { UIHashableHostingController(rootView: $0) }
        let viewControllers = navigationController.viewControllers.inserted(contentsOf: viewControllerToInsert, at: index)
        setViewControllers(viewControllers, animated: animated, completion: completion)
    }

    public func pop(animated: Bool, completion: (() -> Void)?) {
        UIView.performWithTransaction({
            navigationController.popViewController(animated: animated)
        }, completion: completion)
    }

    public func popToRoot(animated: Bool, completion: (() -> Void)?) {
        UIView.performWithTransaction({
            navigationController.popToRootViewController(animated: animated)
        }, completion: completion)
    }

    public func present(
        _ view: AnyHashableView,
        animated: Bool,
        presentationStyle: UIModalPresentationStyle,
        transitionStyle: UIModalTransitionStyle,
        completion: (() -> Void)?
    ) {
        let viewController = UIHashableHostingController(rootView: view)
        viewController.modalPresentationStyle = presentationStyle
        viewController.modalTransitionStyle = transitionStyle
        presentedViewController.present(viewController, animated: animated, completion: completion)
    }

    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        presentedViewController.dismiss(animated: animated, completion: completion ?? {})
    }

    public func popToView<T: View>(withType type: T.Type, animated: Bool, completion: (() -> Void)?) {
        let stack = navigationController.viewControllers.compactMap { $0 as? UIHashableHostingController }
        if let viewController = stack.first(where: { $0.type == type }) {
            UIView.performWithTransaction({
                navigationController.popToViewController(viewController, animated: animated)
            }, completion: completion)
        }
    }
}
