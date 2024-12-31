//
//  RoutableNavigationController.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 31/12/2024.
//

import SwiftUI

public struct RoutableNavigationController<NavigationRouter: NavigationControllerRouterInterface>: View {
    @ObservedObject private var router: NavigationRouter
    let configurations: NavigationRouterConfigurations

    public init(router: NavigationRouter, configurations: NavigationRouterConfigurations = .init()) {
        _router = ObservedObject(wrappedValue: router)
        self.configurations = configurations
    }

    public var body: some View {
        RepresentableViewController(viewController: router.navigationController)
            .ignoresSafeArea()
            .onAppear {
                setConfigurations(configurations)
            }
    }

    func setConfigurations(_ configurations: NavigationRouterConfigurations) {
        setNavigationBarHidden(configurations.hideNavigationBar, animated: true)
        setBackButtonImage(configurations.backButtonImage)
    }

    public func setNavigationBarHidden(_ hidden: Bool, animated: Bool) {
        router.navigationController.setNavigationBarHidden(hidden, animated: animated)
    }

    public func setBackButtonImage(_ image: UIImage?) {
        router.navigationController.navigationBar.backIndicatorImage = image
        router.navigationController.navigationBar.backIndicatorTransitionMaskImage = image
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
