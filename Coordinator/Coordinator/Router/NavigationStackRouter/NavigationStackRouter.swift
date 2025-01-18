//
//  NavigationStackRouter.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 13/10/2024.
//

import SwiftUI

@MainActor
public protocol NavigationStackRouterInterface: Router, ObservableObject {
    var rootView: AnyHashableView? { get set }
    var navigationStack: [AnyHashableView] { get set }
    var fullScreenCoverView: AnyHashableView? { get set }
    var sheetView: AnyHashableView? { get set }
}

@MainActor
public class NavigationStackRouter: NavigationStackRouterInterface {
    @Published public var rootView: AnyHashableView?
    @Published public var navigationStack: [AnyHashableView] = []
    @Published public var fullScreenCoverView: AnyHashableView?
    @Published public var sheetView: AnyHashableView?

    var transaction = Transaction()

    public init() {}

    public func push(_ view: AnyHashableView, animated: Bool, completion: (() -> Void)?) {
        UIView.performWithTransaction({
            transaction.disablesAnimations = !animated

            let hashableView = view
            withTransaction(transaction) {
                if rootView != nil {
                    navigationStack.append(hashableView)
                } else {
                    rootView = hashableView
                }
            }
        }, completion: completion)
    }

    public func push(contentsOf viewsToAppend: [AnyHashableView], animated: Bool, completion: (() -> Void)?) {
        var viewsToPush = navigationStack + viewsToAppend
        if let rootView {
            viewsToPush = [rootView] + viewsToPush
        }
        setViews(viewsToPush, animated: animated, completion: completion)
    }

    public func setView(_ view: AnyHashableView, animated: Bool, completion: (() -> Void)?) {
        setViews([view], animated: animated, completion: completion)
    }

    public func setViews(_ views: [AnyHashableView], animated: Bool, completion: (() -> Void)?) {
        UIView.performWithTransaction({
            transaction.disablesAnimations = !animated

            withTransaction(transaction) {
                guard let firstView = views.first else {
                    rootView = nil
                    navigationStack = []
                    return
                }

                rootView = firstView

                if views.count > 1 {
                    let intermediateViews = views.dropFirst().dropLast()
                    let lastView = views.last

                    navigationStack = intermediateViews.map { $0 }

                    if let lastView {
                        navigationStack.append(lastView)
                    }
                } else {
                    navigationStack = []
                }
            }
        }, completion: completion)
    }

    public func replaceLastView(with view: AnyHashableView, animated: Bool, completion: (() -> Void)?) {
        replaceView(at: navigationStack.endIndex, with: view, animated: animated, completion: completion)
    }

    public func replaceFirstView(with view: AnyHashableView, animated: Bool, completion: (() -> Void)?) {
        replaceView(at: 0, with: view, animated: animated, completion: completion)
    }

    public func replaceView(at index: Int, with view: AnyHashableView, animated: Bool, completion: (() -> Void)?) {
        let stack = Array([rootView].compactMap { $0 } + navigationStack)
        setViews(stack.replacedElement(at: index, with: view), animated: animated, completion: completion)
    }

    public func insert(_ view: AnyHashableView, at index: Int, animated: Bool, completion: (() -> Void)?) {
        insert(contentsOfViews: [view], at: index, animated: animated, completion: completion)
    }

    public func insert(contentsOfViews viewsToInsert: [AnyHashableView], at index: Int, animated: Bool, completion: (() -> Void)?) {
        let stack = [rootView].compactMap { $0 } + navigationStack

        setViews(
            stack.inserted(contentsOf: viewsToInsert, at: index),
            animated: animated,
            completion: completion
        )
    }

    public func pop(animated: Bool, completion: (() -> Void)?) {
        UIView.performWithTransaction({
            transaction.disablesAnimations = !animated

            withTransaction(transaction) {
                _ = navigationStack.removeLast()
            }
        }, completion: completion)
    }

    public func popToRoot(animated: Bool, completion: (() -> Void)?) {
        UIView.performWithTransaction({
            transaction.disablesAnimations = !animated

            withTransaction(transaction) {
                navigationStack.removeAll()
            }
        }, completion: completion)
    }

    public func present(
        _ view: AnyHashableView,
        animated: Bool,
        presentationStyle: UIModalPresentationStyle,
        transitionStyle: UIModalTransitionStyle,
        completion: (() -> Void)?
    ) {
        UIView.performWithTransaction({
            transaction.disablesAnimations = !animated

            withTransaction(transaction) {
                switch presentationStyle {
                case .fullScreen:
                    fullScreenCoverView = view
                    sheetView = nil
                default:
                    sheetView = view
                    fullScreenCoverView = nil
                }
            }
        }, completion: completion)
    }

    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        UIView.performWithTransaction({
            transaction.disablesAnimations = !animated

            withTransaction(transaction) {
                sheetView = nil
                fullScreenCoverView = nil
            }
        }, completion: completion)
    }

    public func popToView<T: View>(withType type: T.Type, animated: Bool, completion: (() -> Void)?) {
        if let index = navigationStack.lastIndex(where: { $0.type == T.self }) {
            UIView.performWithTransaction({
                navigationStack = Array(navigationStack[...index])
            }, completion: completion)
        } else if rootView?.type == T.self {
            popToRoot(animated: animated, completion: completion)
        }
    }
}
