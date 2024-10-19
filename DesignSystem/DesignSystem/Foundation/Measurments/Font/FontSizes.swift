//
//  FontSizes.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 09/10/2024.
//

import Foundation

public extension DesignSystem.Foundation.Measurements.Font {
    enum Sizes {
        case h1
        case h2
        case h3
        case h4
        case p1
        case p2
        case p3
        case p4

        var size: CGFloat {
            switch self {
            case .h1: 34
            case .h2: 28
            case .h3: 22
            case .h4: 20
            case .p1: 18
            case .p2: 16
            case .p3: 14
            case .p4: 12
            }
        }

        var lineSpacing: CGFloat {
            switch self {
            case .h1:
                10
            case .h2:
                10
            case .h3:
                10
            case .h4:
                10
            case .p1:
                -15
            case .p2:
                -15
            case .p3:
                -15
            case .p4:
                -15
            }
        }
    }
}

internal extension CGFloat {
    static let fontSizes = DesignSystem.Foundation.Measurements.Font.Sizes.self
}
