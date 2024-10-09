//
//  tabBarBackgroundColor.swift
//
//
//  Created by Ahmed Yamany on 22/04/2024.
//

import SwiftUI

private struct TabBarBackgroundColorChanger: UIViewRepresentable {
    let color: Color
    init(_ color: Color) {
        self.color = color
    }
    func makeUIView(context: Context) -> some UIView { UIView() }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.03) {
            uiView.parentViewController?.tabBarController?.tabBar.backgroundColor = UIColor(color)
        }
    }
}

public extension View {
    @ViewBuilder
    func tabBarBackgroundColor(_ color: Color) -> some View {
        background {
            TabBarBackgroundColorChanger(color)
        }
    }
}
