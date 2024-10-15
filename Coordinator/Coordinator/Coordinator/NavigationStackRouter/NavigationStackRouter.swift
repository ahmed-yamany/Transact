//
//  NavigationStackRouter.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 13/10/2024.
//

import SwiftUI

public protocol NavigationStackRouterInterface: Router, ObservableObject {
    var rootView: AnyHashableView? { get set }
    var stack: [AnyHashableView] { get set }
    var modal: AnyHashableView? { get set }
}

public class NavigationStackRouter: NavigationStackRouterInterface {
    @Published public var rootView: AnyHashableView?
    @Published public var stack: [AnyHashableView] = []
    
    @Published public var modal: AnyHashableView?
    
    var transaction = Transaction()

    public init() {}
    
    public func push(_ view: some View, animated: Bool, completion: (() -> Void)?) {
        transaction.disablesAnimations = !animated
        
        let hashableView = AnyHashableView(view.lifecycle(onDidLoad: completion))
        
        withTransaction(transaction) {
            if rootView != nil {
                stack.append(hashableView)
            } else {
                rootView = hashableView
            }
        }
    }
    
    public func setView(_ view: some View, animated: Bool, completion: (() -> Void)?) {
        setViews([view], animated: animated, completion: completion)
    }
    
    public func setViews(_ views: [some View], animated: Bool, completion: (() -> Void)?) {
        var transaction = Transaction()
        transaction.disablesAnimations = !animated

        withTransaction(transaction) {
            rootView = if let firstView = views.first {
                AnyHashableView(firstView)
            } else { nil }
            
            let lastView = AnyHashableView(views.last.lifecycle(onDidLoad: completion))
            stack = views.removedFirst().removedLast().map { AnyHashableView($0) } + [lastView]
        }
    }
    
    public func present(
        _ view: some View,
        animated: Bool,
        presentationStyle: UIModalPresentationStyle,
        transitionStyle: UIModalTransitionStyle,
        completion: (() -> Void)?
    ) {
        modal = AnyHashableView(view)
    }
}
