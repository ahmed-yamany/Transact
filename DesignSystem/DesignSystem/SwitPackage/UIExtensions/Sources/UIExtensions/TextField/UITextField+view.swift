//
//  UITextField+view.swift
//  
//
//  Created by Ahmed Yamany on 22/04/2024.
//

#if os(iOS)
import UIKit

public extension UITextField {
    /// Add padding to the left of the textfield rect.
    ///
    /// - Parameter padding: amount of padding to apply to the left of the textfield rect.
    func setLeftPadding(_ padding: CGFloat?) {
        if let padding {
            leftView = createPaddingView(padding)
            leftViewMode = .always
        } else {
            leftView = nil
        }
    }
    
    /// Add padding to the right of the textfield rect.
    ///
    /// - Parameter padding: amount of padding to apply to the right of the textfield rect.
    func setRightPadding(_ padding: CGFloat?) {
        if let padding {
            rightView = createPaddingView(padding)
            rightViewMode = .always
        } else {
            rightView = nil
        }
    }
    
    private func createPaddingView(_ padding: CGFloat) -> UIView {
        UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
    }
}

public extension UITextField {
    /// Adds an image to the right side of the UITextField.
    ///
    /// - Parameters:
    ///   - image: The image to be displayed.
    ///   - tintColor: The color to apply to the image.
    func setRightIcon(_ image: UIImage?, padding: CGFloat, tintColor: UIColor = .blue) {
        if let image = image {
            let view = createIconView(from: image, padding: padding, tintColor: tintColor)
            rightView = view
            rightViewMode = .always
        } else {
            rightView = nil
        }
    }
    
    /// Adds an image to the left side of the UITextField.
    ///
    /// - Parameters:
    ///   - image: The image to be displayed.
    ///   - tintColor: The color to apply to the image.
    func setLeftIcon(_ image: UIImage?, padding: CGFloat, tintColor: UIColor) {
        if let image = image {
            let view = createIconView(from: image, padding: padding, tintColor: tintColor)
            leftView = view
            leftViewMode = .always
        } else {
            leftView = nil
        }
    }
    
    private func createIconView(from image: UIImage?, padding: CGFloat, tintColor: UIColor) -> UIView {
        let view = UIView()
        let imageView = UIImageView(image: image)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.tintColor = tintColor
        view.addSubview(imageView)
        
        view.widthAnchor.constraint(equalToConstant: imageView.bounds.width + padding).isActive = true
        view.heightAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        return view
    }
}
#endif
