//
//  ContentSizeCategory+FontRatio.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 09/10/2024.
//

import SwiftUI

public extension ContentSizeCategory {
    var fontRatio: CGFloat {
        switch self {
        case .extraSmall: return 0.8
        case .small: return 0.85
        case .medium: return 0.9
        case .large: return 1 // Default
        case .extraLarge: return 1.1
        case .extraExtraLarge: return 1.2
        case .extraExtraExtraLarge: return 1.35
        case .accessibilityMedium: return 1.6
        case .accessibilityLarge: return 1.9
        case .accessibilityExtraLarge: return 2.35
        case .accessibilityExtraExtraLarge: return 2.75
        case .accessibilityExtraExtraExtraLarge: return 3.1
        @unknown default: return 1
        }
    }
}
