//
//  FontSizes.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 09/10/2024.
//

import Foundation

public extension DesignSystem.Foundation.Measurements.Font {
    enum Sizes {
        /// 34
        public static var h1: CGFloat = 34
        /// 28
        public static var h2: CGFloat = 28
        /// 22
        public static var h3: CGFloat = 22
        /// 20
        public static var h4: CGFloat = 20
        /// 18
        public static var p1: CGFloat = 18
        /// 16
        public static var p2: CGFloat = 16
        /// 14
        public static var p3: CGFloat = 14
        /// 12
        public static var p4: CGFloat = 12
    }
}

internal extension CGFloat {
    static let fontSizes = DesignSystem.Foundation.Measurements.Font.Sizes.self
}
