//
//  UIButton+Loading.swift
//  
//
//  Created by Ahmed Yamany on 22/04/2024.
//

#if os(iOS)
import UIKit

public extension UIButton {
    /// Starts showing a loading indicator on the button.
    ///
    /// This method hides all subviews of the button and adds a UIActivityIndicatorView
    /// as a subview to indicate loading.
    func startLoading() {
        subviews.forEach { $0.isHidden = true }
        
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        
        addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    /// Stops showing the loading indicator on the button.
    ///
    /// This method stops the animation of any UIActivityIndicatorView found among the
    /// button's subviews and removes it from the button's subviews. It then unhides
    /// any other subviews of the button.
    func stopLoading() {
        subviews.forEach { view in
            if let indicator = view as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            } else {
                view.isHidden = false
            }
        }
    }
}
#endif
