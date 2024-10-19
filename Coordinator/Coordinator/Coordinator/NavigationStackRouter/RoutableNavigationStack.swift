//
//  RoutableNavigationStack.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 14/10/2024.
//

import SwiftUI

@available(iOS 16.0, *)
public struct RoutableNavigationStack<NavigationRouter: NavigationStackRouterInterface>: View {
    @ObservedObject private var router: NavigationRouter
    
    public init(router: NavigationRouter) {
        self.router = router
    }
    
    public var body: some View {
        NavigationStack(path: $router.navigationStack) {
            Group {
                router.rootView
            }
            .toolbar(.visible, for: .navigationBar)
            .navigationDestination(for: AnyHashableView.self) { $0 }
            .fullScreenCover(item: $router.fullScreenCoverView) { $0 }
            .sheet(item: $router.sheetView) { $0 }
        }
    }
}
