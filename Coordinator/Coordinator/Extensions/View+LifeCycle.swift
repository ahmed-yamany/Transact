//
//  View+LifeCycle.swift
//  Coordinator
//
//  Created by Ahmed Yamany on 15/10/2024.
//

import SwiftUI

public extension View {
    func lifecycle(onDidLoad: (() -> Void)? = nil) -> some View {
        modifier(LifecycleModifier(onDidLoad: onDidLoad))
    }
}

private struct LifecycleModifier: ViewModifier {
    var onDidLoad: (() -> Void)?

    func body(content: Content) -> some View {
        content.background(LifecycleHandlerView(onDidLoad: onDidLoad))
    }
}

private struct LifecycleHandlerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController

    var onDidLoad: (() -> Void)?

    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> UIViewControllerType {
        let controller = LifecycleHandlerViewController()
        controller.onDidLoad = onDidLoad
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

private class LifecycleHandlerViewController: UIViewController {
    var onDidLoad: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        onDidLoad?()
    }
}
