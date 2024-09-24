//
//  File.swift
//  
//
//  Created by Ahmed Yamany on 22/04/2024.
//

#if os(iOS)
import UIKit

public extension UITextField {
    /// Configures the text field to support secure text entry with a toggle button.
    ///
    /// This method adds a toggle button to the right side of the text field, allowing the user
    /// to switch between secure and plain text entry modes. The appearance of the toggle button
    /// can be customized with the provided image and tint color.
    ///
    /// - Parameters:
    ///   - image: The image to be used for the toggle button when the text is obscured.
    ///            Default is a system image of an eye with a slash indicating obscured text.
    ///   - isSecureImage: The image to be used for the toggle button when the text is not obscured.
    ///                   Default is a system image of an eye indicating plain text.
    ///   - tintColor: The tint color to be applied to the toggle button.
    func makeSecured(
        image: UIImage? = UIImage(systemName: "eye.slash"),
        isSecureImage: UIImage? = UIImage(systemName: "eye"),
        withTintColor tintColor: UIColor = .blue
    ) {
        // Create a UIButton to act as the toggle button for secure text entry.
        let button = UIButton()
        button.widthAnchor.constraint(equalToConstant: 36).isActive = true
        button.tintColor = tintColor
        button.addTarget(self, action: #selector(securedButtonAction(_:)), for: .touchUpInside)
        rightView = button
        rightViewMode = .always
        securedButtonAction(button)
    }
    
    @objc private func securedButtonAction(_ sender: UIButton) {
        isSecureTextEntry.toggle()
        
        if isSecureTextEntry {
            sender.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
}
#endif
