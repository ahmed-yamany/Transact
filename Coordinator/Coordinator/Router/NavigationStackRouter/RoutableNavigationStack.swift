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
        _router = ObservedObject(wrappedValue: router)
    }

    public var body: some View {
        NavigationStack(path: $router.navigationStack) {
            Group {
                router.rootView
            }
            .toolbar(router.hideNavigationBar ? .hidden : .visible, for: .navigationBar)
            .navigationDestination(for: AnyHashableView.self) {
                $0.toolbar(router.hideNavigationBar ? .hidden : .visible, for: .navigationBar)
                    .onCondition(router.animateHideNavigationBar) {
                        $0.animation(.default, value: router.hideNavigationBar)
                    }
            }
            .fullScreenCover(item: $router.fullScreenCoverView) { $0 }
            .sheet(item: $router.sheetView) { $0 }
            .navigationBarBackButtonImage(router.backButtonImage)
        }
    }
}

