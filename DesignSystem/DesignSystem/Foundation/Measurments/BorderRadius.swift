//
//  BorderRadius.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 26/09/2024.
//

import Foundation

public extension DesignSystem.Foundation.Measurements {
    enum BorderRadius {
        /// 2 pts border radius.
        public static let xxSmall: CGFloat = 2
        /// 3 pts border radius.
        public static let desktop: CGFloat = 3
        /// 4 pts border radius.
        public static let xSmall: CGFloat = 4
        /// 6 pts border radius.
        public static let small: CGFloat = 6
        /// 8 pts border radius.
        public static let medium: CGFloat = 8
        /// 12 pts border radius.
        public static let xMedium: CGFloat = 12
        /// 16 pts border radius.
        public static let large: CGFloat = 16
        /// 100 pts border radius.
        public static let full: CGFloat = 100
        
        /// The default 6 pts border radius.
        public static var `default`: CGFloat {
            Self.small
        }
    }
}

internal extension CGFloat {
    static let borderRadius = DesignSystem.Foundation.Measurements.BorderRadius.self
}
