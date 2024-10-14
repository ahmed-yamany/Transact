//
//  RoutableNavigationStack.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 14/10/2024.
//

import SwiftUI

public struct RoutableNavigationStack<NavigationRouter: NavigationStackRouterInterface, Root: View>: View {
    @ObservedObject private var router: NavigationRouter
    @ViewBuilder
    private let root: () -> Root
    
    public init(router: NavigationRouter, @ViewBuilder root: @escaping () -> Root) {
        self.router = router
        self.root = root
    }
    
    public var body: some View {
        NavigationStack(path: $router.stack) {
            root()
                .navigationDestination(for: AnyRoutableView.self) { view in
                    view
                }
        }
    }
}
