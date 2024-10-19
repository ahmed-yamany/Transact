//
//  Padding.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 09/10/2024.
//

import SwiftUI

public extension DesignSystem.Foundation.Measurements {
    static var Padding: EdgeInsets = EdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24)
}
internal extension CGFloat {
    static let padding = DesignSystem.Foundation.Measurements.Padding.self
}
