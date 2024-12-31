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
        let navigationBar = uiView.parentViewController?.navigationController?.navigationBar
        if let image {
            navigationBar?.backIndicatorImage = image
            navigationBar?.backIndicatorTransitionMaskImage = image
        }
    }
}

@available(iOS 15.0, *)
internal extension View {
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
