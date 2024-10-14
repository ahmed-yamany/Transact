//
//  NavigationStackRouter.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 13/10/2024.
//

import SwiftUI

public protocol NavigationStackRouterInterface: Router, ObservableObject {
    var stack: [AnyRoutableView] { get set }
    var modal: AnyRoutableView? { get set }
}

public class NavigationStackRouter: NavigationStackRouterInterface {
    
    @Published public var stack: [AnyRoutableView] = []
    @Published public var modal: AnyRoutableView?
    
    public init() {}
    
    public func push(_ view: some RoutableView, animated: Bool, completion: @escaping () -> Void) {
        stack.append(AnyRoutableView(view))
    }
    
    public func setView(_ view: some RoutableView, animated: Bool, completion: @escaping () -> Void) {
        setViews([view], animated: animated, completion: completion)
    }
    
    public func setViews(_ views: [some RoutableView], animated: Bool, completion: @escaping () -> Void) {
        stack = views.map { AnyRoutableView($0) }
    }
    
    public func present(
        _ view: some RoutableView,
        animated: Bool,
        presentationStyle: UIModalPresentationStyle,
        transitionStyle: UIModalTransitionStyle,
        completion: @escaping () -> Void
    ) {
        modal = AnyRoutableView(view)
    }
}
