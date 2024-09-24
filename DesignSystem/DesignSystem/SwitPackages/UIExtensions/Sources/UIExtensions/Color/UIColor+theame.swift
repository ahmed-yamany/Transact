//
//  File.swift
//  
//
//  Created by Ahmed Yamany on 23/09/2024.
//

#if os(iOS)
import UIKit

public extension UIColor {
    /// Initializes and returns a color object using the specified hexadecimal string and alpha value.
    ///
    /// - Parameters:
    ///   - hexString: The hexadecimal string representation of the color (e.g., "#RRGGBB" or "RRGGBB").
    ///   - alpha: The alpha value of the color, ranging from 0.0 to 1.0. Default is 1.0 (fully opaque).
    /// - Returns: A new color object initialized with the specified hexadecimal string and alpha value,
    ///            or nil if the string is invalid.
    static func color(dark: UIColor, light: UIColor) -> UIColor {
        
        if UITraitCollection.current.userInterfaceStyle == .dark {
            return dark
        } else {
            return light
        }
    }
}
#endif
