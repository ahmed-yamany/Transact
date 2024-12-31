//
//  RoutableNavigationController.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 31/12/2024.
//

import SwiftUI

public struct RoutableNavigationController<NavigationRouter: NavigationControllerRouterInterface>: View {
    @ObservedObject private var router: NavigationRouter

    public init(router: NavigationRouter) {
        _router = ObservedObject(wrappedValue: router)
    }

    public var body: some View {
        RepresentableViewController(viewController: router.navigationController)
            .ignoresSafeArea()
    }
}

private struct RepresentableViewController: UIViewControllerRepresentable {
    let viewController: UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
