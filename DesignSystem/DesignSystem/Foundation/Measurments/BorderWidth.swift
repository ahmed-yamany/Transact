//
//  BorderWidth.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 26/09/2024.
//

import UIKit

public extension DesignSystem.Foundation.Measurements {
    enum BorderWidth {
        /// 1 pixel border width.
        public static let hairline: CGFloat = 1.0 / UIScreen.main.scale
        /// 0.5 pt border width.
        public static let thin: CGFloat = 0.5
        /// A default 1 pt border.
        public static let `default`: CGFloat = 1.0
        /// 2 pt border width used for actively selected or highlighted components.
        public static let active: CGFloat = 2.0
    }
}

internal extension CGFloat {
    static let borderWidth = DesignSystem.Foundation.Measurements.BorderWidth.self
}
