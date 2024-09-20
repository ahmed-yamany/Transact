//
//  navigationItemBackButtonTitle.swift
//
//
//  Created by Ahmed Yamany on 22/04/2024.
//

import SwiftUI

private struct NavigationItemBackButtonTitleChanger: UIViewRepresentable {
    let title: String
    
    func makeUIView(context: Context) -> some UIView { UIView() }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
//            uiView.parentViewController?.navigationItem.backButtonTitle = title
            uiView.parentViewController?.navigationController?.visibleViewController?.navigationItem.backButtonTitle = title
        }
    }
}

private struct NavigationItemsBackButtonTitleChanger: UIViewRepresentable {
    let title: String
    
    func makeUIView(context: Context) -> some UIView { UIView() }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
            uiView.parentViewController?.navigationItem.backButtonTitle = title
            uiView.parentViewController?.navigationController?.delegate = context.coordinator
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    

    class Coordinator: NSObject, UINavigationControllerDelegate {
        let parent: NavigationItemsBackButtonTitleChanger
        
        init(parent: NavigationItemsBackButtonTitleChanger) {
            self.parent = parent
        }
        
        func navigationController(
            _ navigationController: UINavigationController,
            willShow viewController: UIViewController,
            animated: Bool
        ) {
            viewController.navigationItem.backButtonTitle = parent.title
        }
    }
}

public extension View {
    /**
     Sets the back button title for the current view in a navigation stack.
     
     - Parameter title: The new title for the back button.
     */
    @ViewBuilder
    func navigationItemBackButtonTitle(_ title: String) -> some View {
        background {
            NavigationItemBackButtonTitleChanger(title: title)
        }
    }
    
    /**
     Sets the back button title for the current view and its all  views that will appear in a navigation stack.
     
     - Parameter title: The new title for the back button.
     */
    @ViewBuilder
    func navigationItemsBackButtonTitle(_ title: String) -> some View {
        background {
            NavigationItemsBackButtonTitleChanger(title: title)
        }
    }
}
