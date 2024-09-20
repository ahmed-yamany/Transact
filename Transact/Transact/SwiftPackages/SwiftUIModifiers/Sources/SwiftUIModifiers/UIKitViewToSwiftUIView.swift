//
//  UIKitViewToSwiftUIView.swift
//
//
//  Created by Ahmed Yamany on 22/04/2024.
//

import SwiftUI

struct UIKitViewControllerToSwiftUIView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    private let controller: () -> UIViewControllerType
    
    init(controller: @escaping () -> UIViewControllerType) {
        self.controller = controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        controller()
    }
}

public extension UIViewController {
    @ViewBuilder
    func toSwiftUI() -> some View {
        UIKitViewControllerToSwiftUIView(controller: { self })
    }
}

struct UIKitViewToSwiftUIView: UIViewRepresentable {
    
    typealias UIViewType = UIView
    
    private let view: () -> UIViewType
    
    init(view: @escaping () -> UIViewType) {
        self.view = view
    }
   
    func makeUIView(context: Context) -> UIView {
        view()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) { }
}

public extension UIView {
    @ViewBuilder
    func toSwiftUI() -> some View {
        UIKitViewToSwiftUIView(view: { self })
    }
}
