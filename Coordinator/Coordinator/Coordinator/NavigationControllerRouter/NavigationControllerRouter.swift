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

    public func push(_ view: AnyHashableView, animated: Bool, completion: (() -> Void)?) {
        let viewController = UIHashableHostingController(rootView: view)
        navigationRouter.push(viewController, animated: animated, completion: completion ?? {})
    }

    public func push(contentsOf viewsToAppend: [AnyHashableView], animated: Bool, completion: (() -> Void)?) {
        navigationRouter.push(
            contentsOf: viewsToAppend.map { UIHostingController(rootView: $0) },
            animated: animated,
            completion: completion ?? {})
    }

    public func setView(_ view: AnyHashableView, animated: Bool, completion: (() -> Void)?) {
        setViews([view], animated: animated, completion: completion ?? {})
    }

    public func setViews(_ views: [AnyHashableView], animated: Bool, completion: (() -> Void)?) {
        let viewControllers = views.map { UIHashableHostingController(rootView: $0) }
        navigationRouter.setViewControllers(viewControllers, animated: animated, completion: completion ?? {})
    }

    public func replaceLastView(with view: AnyHashableView, animated: Bool, completion: (() -> Void)?) {
        navigationRouter.replaceLastViewController(with: UIHashableHostingController(rootView: view), animated: animated, completion: completion ?? {})
    }

    public func replaceFirstView(with view: AnyHashableView, animated: Bool, completion: (() -> Void)?) {
        navigationRouter.replaceFirstViewController(with: UIHashableHostingController(rootView: view), animated: animated, completion: completion ?? {})
    }

    public func insert(_ view: AnyHashableView, at index: Int, animated: Bool, completion: (() -> Void)?) {
        navigationRouter.insert(UIHashableHostingController(rootView: view), at: index, animated: animated, completion: completion ?? {})
    }

    public func insert(contentsOfViews viewsToInsert: [AnyHashableView], at index: Int, animated: Bool, completion: (() -> Void)?) {
        let viewControllers = viewsToInsert.map { UIHashableHostingController(rootView: $0) }
        navigationRouter.insert(contentsOfViewControllers: viewControllers, at: index, animated: animated, completion: completion ?? {})
    }

    public func pop(animated: Bool, completion: (() -> Void)?) {
        navigationRouter.pop(animated: animated, completion: completion ?? {})
    }

    public func popToRoot(animated: Bool, completion: (() -> Void)?) {
        navigationRouter.popToRoot(animated: animated, completion: completion ?? {})
    }

    public func present(
        _ view: AnyHashableView,
        animated: Bool,
        presentationStyle: UIModalPresentationStyle,
        transitionStyle: UIModalTransitionStyle,
        completion: (() -> Void)?
    ) {
        let viewController = UIHashableHostingController(rootView: view)

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

    public func popToView<T: View>(withType type: T.Type, animated: Bool, completion: (() -> Void)?) {
        let stack = navigationRouter.viewControllers.compactMap { $0 as? UIHashableHostingController }
        if let index = stack.firstIndex(where: { $0.type == type}) {
            navigationRouter.popToViewController(navigationController.viewControllers[index], animated: animated, completion: completion ?? {})
        }
    }
}

class UIHashableHostingController: UIHostingController<AnyHashableView> {
    let type: Any.Type

    override init(rootView: AnyHashableView) {
        type = rootView.type
        super.init(rootView: rootView)
    }

    @MainActor @preconcurrency dynamic required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
