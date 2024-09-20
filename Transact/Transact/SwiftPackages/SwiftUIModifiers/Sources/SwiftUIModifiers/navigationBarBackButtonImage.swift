//
//  navigationBarBackButtonImage.swift
//
//
//  Created by Ahmed Yamany on 22/04/2024.
//

import SwiftUI

private struct NavigationBarBackButtonImageChanger: UIViewRepresentable {
    let image: UIImage?
    
    func makeUIView(context: Context) -> some UIView { UIView() }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
            let navigationBar = uiView.parentViewController?.navigationController?.navigationBar
            navigationBar?.backIndicatorImage = image
            navigationBar?.backIndicatorTransitionMaskImage = image
        }
    }
}

public extension View {
    /**
     Sets the back button image for the current view.
     
     - Parameter image: The new image for the back button.
     - Returns: A modified view with the specified back button image.
     */
    
    @ViewBuilder
    func navigationBarBackButtonImage(_ image: UIImage?) -> some View {
        background {
            NavigationBarBackButtonImageChanger(image: image)
        }
    }
}
