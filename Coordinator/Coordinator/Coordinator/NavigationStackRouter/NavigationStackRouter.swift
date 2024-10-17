//
//  NavigationStackRouter.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 13/10/2024.
//

import SwiftUI
import NavigationRouter

public protocol NavigationStackRouterInterface: Router, ObservableObject {
    var rootView: AnyHashableView? { get set }
    var navigationStack: [AnyHashableView] { get set }
    var fullScreenCoverView: AnyHashableView? { get set }
    var sheetView: AnyHashableView? { get set }
}

public class NavigationStackRouter: NavigationStackRouterInterface {
    @Published public var rootView: AnyHashableView?
    @Published public var navigationStack: [AnyHashableView] = []
    @Published public var fullScreenCoverView: AnyHashableView?
    @Published public var sheetView: AnyHashableView?
    
    var transaction = Transaction()
    
    public init() {}
    
    public func push(_ view: some View, animated: Bool, completion: (() -> Void)?) {
        transaction.disablesAnimations = !animated
        
        let hashableView = AnyHashableView(view.lifecycle(onDidLoad: completion))
        
        withTransaction(transaction) {
            if rootView != nil {
                navigationStack.append(hashableView)
            } else {
                rootView = hashableView
            }
        }
    }
    
    public func push(contentsOf viewsToAppend: [some View], animated: Bool, completion: (() -> Void)?) {
        setViews(navigationStack + viewsToAppend.map { AnyHashableView($0) }, animated: animated, completion: completion)
    }
    
    public func setView(_ view: some View, animated: Bool, completion: (() -> Void)?) {
        setViews([view], animated: animated, completion: completion)
    }
    
    public func setViews(_ views: [some View], animated: Bool, completion: (() -> Void)?) {
        transaction.disablesAnimations = !animated
        
        withTransaction(transaction) {
            guard let firstView = views.first else {
                rootView = nil
                navigationStack = []
                return
            }
            if views.count == 1 {
                rootView = AnyHashableView(firstView.lifecycle(onDidLoad: completion))
            } else {
                rootView = AnyHashableView(firstView)
            }
            
            if views.count > 1 {
                let intermediateViews = views.dropFirst().dropLast()
                let lastView = views.last
                
                navigationStack = intermediateViews.map { AnyHashableView($0) }
                navigationStack.append(AnyHashableView(lastView.lifecycle(onDidLoad: completion)))
            } else {
                navigationStack = []
            }
        }
    }
    
    public func replaceLastView(with view: some View, animated: Bool, completion: (() -> Void)?) {
        replaceView(at: navigationStack.count - 1, with: view, animated: animated, completion: completion)
    }
    
    public func replaceFirstView(with view: some View, animated: Bool, completion: (() -> Void)?) {
        replaceView(at: 0, with: view, animated: animated, completion: completion)
    }
    
    public func replaceView(at index: Int, with view: some View, animated: Bool, completion: (() -> Void)?) {
        let stack = self.navigationStack.replacedElement(at: index, with: AnyHashableView(view))
        setViews(stack, animated: animated, completion: completion)
    }
    
    public func insert(_ view: some View, at index: Int, animated: Bool, completion: (() -> Void)?) {
        let views = self.navigationStack.inserted(AnyHashableView(view), at: index)
        setViews(views, animated: animated, completion: completion)
    }
    
    public func insert(contentsOfViews viewsToInsert: [some View], at index: Int, animated: Bool, completion: (() -> Void)?) {
        let views = self.navigationStack.inserted(contentsOf: viewsToInsert.map { AnyHashableView($0) }, at: index)
        setViews(views, animated: animated, completion: completion)
    }
    
    public func pop(animated: Bool, completion: (() -> Void)?) {
        transaction.disablesAnimations = !animated
        
        withTransaction(transaction) {
            navigationStack.removeLast()
            completion?()
        }
    }
    
    public func popToRoot(animated: Bool, completion: (() -> Void)?) {
        transaction.disablesAnimations = !animated
        
        withTransaction(transaction) {
            navigationStack.removeAll()
            completion?()
        }
    }
    
    public func present(
        _ view: some View,
        animated: Bool,
        presentationStyle: UIModalPresentationStyle,
        transitionStyle: UIModalTransitionStyle,
        completion: (() -> Void)?
    ) {
        transaction.disablesAnimations = !animated
        
        withTransaction(transaction) {
            switch presentationStyle {
                case .fullScreen:
                    fullScreenCoverView = AnyHashableView(view.lifecycle(onDidLoad: completion))
                    sheetView = nil
                default:
                    sheetView = AnyHashableView(view.lifecycle(onDidLoad: completion))
                    fullScreenCoverView = nil
            }
            
            completion?()
        }
    }
    
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        transaction.disablesAnimations = !animated
        
        withTransaction(transaction) {
            sheetView = nil
            fullScreenCoverView = nil
            completion?()
        }
    }
}
