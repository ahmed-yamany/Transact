//
//  UIColor+hex.swift
//
//
//  Created by Ahmed Yamany on 22/04/2024.
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
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var cleanedString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if cleanedString.hasPrefix("#") {
            cleanedString.remove(at: cleanedString.startIndex)
        }
        
        var rgb: UInt64 = 0
        
        Scanner(string: cleanedString).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
#endif
