//
//  File.swift
//  
//
//  Created by Ahmed Yamany on 22/04/2024.
//

#if os(iOS)
import UIKit

public extension UIRectCorner {
    /// Converts UIRectCorner to CACornerMask.
    ///
    /// - Returns: A CACornerMask value representing the converted corners.
    func toCACornerMask() -> CACornerMask {
        var cornerMask: CACornerMask = []
        //
        if contains(.topLeft) {
            cornerMask.insert(.layerMinXMinYCorner)
        }
        if contains(.topRight) {
            cornerMask.insert(.layerMaxXMinYCorner)
        }
        if contains(.bottomLeft) {
            cornerMask.insert(.layerMinXMaxYCorner)
        }
        if contains(.bottomRight) {
            cornerMask.insert(.layerMaxXMaxYCorner)
        }
        //
        return cornerMask
    }
}
#endif
