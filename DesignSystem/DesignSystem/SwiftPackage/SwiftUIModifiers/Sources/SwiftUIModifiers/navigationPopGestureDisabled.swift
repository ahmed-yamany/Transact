//
//  navigationPopGestureDisabled.swift
//
//
//  Created by Ahmed Yamany on 22/04/2024.
//

import SwiftUI

private struct NavigationPopGestureDisabler: UIViewRepresentable {
    /// A boolean value indicating whether to disable the interactive pop gesture (`true`) or enable it (`false`).
    let disabled: Bool
    
    func makeUIView(context: Context) -> some UIView { UIView() }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.03) {
            uiView
                .parentViewController?
                .navigationController?
                .interactivePopGestureRecognizer?.isEnabled = !disabled
        }
    }
}

public extension View {
    /// Disables or enables the interactive pop gesture in a navigation controller.
    ///
    /// - Parameter disabled: A boolean value indicating whether to disable (`true`) or enable (`false`) the gesture.
    /// - Returns: A view modified to control the interactive pop gesture.
    @ViewBuilder
    func navigationPopGestureDisabled(_ disabled: Bool) -> some View {
        background {
            NavigationPopGestureDisabler(disabled: disabled)
        }
    }
}
