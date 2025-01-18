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
    let configurations: NavigationRouterConfigurations

    public init(router: NavigationRouter, configurations: NavigationRouterConfigurations = .init()) {
        _router = ObservedObject(wrappedValue: router)
        self.configurations = configurations
    }

    public var body: some View {
        NavigationStack(path: $router.navigationStack) {
            Group {
                router.rootView
            }
            .toolbar(configurations.hideNavigationBar ? .hidden : .visible, for: .navigationBar)
            .navigationDestination(for: AnyHashableView.self) {
                $0.toolbar(configurations.hideNavigationBar ? .hidden : .visible, for: .navigationBar)
            }
            .fullScreenCover(item: $router.fullScreenCoverView) { $0 }
            .sheet(item: $router.sheetView) { $0 }
            .navigationBarBackButtonImage(configurations.backButtonImage)
        }
    }
}
