//
//  File.swift
//  
//
//  Created by Ahmed Yamany on 22/04/2024.
//

#if os(iOS)
import UIKit

public extension UIButton {
    /**
     Set the background color for a specific UIButton state.

     - Parameters:
       - color: The background color to be set.
       - state: The control state for which the background color should be applied.

     Example usage:

     ```swift
     let myButton = UIButton()
     myButton.setBackgroundColor(color: UIColor.blue, forState: .normal)
     ```

     - Warning: This method will override any existing background image for the specified control state.
     */
    func setBackgroundColor(color: UIColor, forState state: UIControl.State) {
        self.clipsToBounds = true  // Add this to maintain corner radius
        let colorImage = UIImage(color: color)
        self.setBackgroundImage(colorImage, for: state)
    }
}
#endif
