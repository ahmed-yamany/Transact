//
//  Spacing.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 26/09/2024.
//

import Foundation

public extension DesignSystem.Foundation.Measurements {
     enum Spacing {
        /// 2 pts.
        public static var xxxSmall: CGFloat = 2
        /// 4 pts.
         public  static var xxSmall: CGFloat = 4
        /// 8 pts.
         public  static var xSmall: CGFloat = 8
        /// 12 pts.
         public  static var small: CGFloat = 12
        /// 16 pts.
         public  static var medium: CGFloat = 16
        /// 20 pts.
         public  static var xMedium: CGFloat = 20
        /// 24 pts.
         public  static var large: CGFloat = 24
        /// 32 pts.
         public  static var xLarge: CGFloat = 32
        /// 44 pts.
         public  static var xxLarge: CGFloat = 44
        /// 60 pts.
         public  static var xxxLarge: CGFloat = 60
    }
}

internal extension CGFloat {
    static let spacing = DesignSystem.Foundation.Measurements.Spacing.self
}
