//
//  FontLetterSpacing.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 09/10/2024.
//

import Foundation
import Localization

public extension DesignSystem.Foundation.Measurements.Font {
    static var letterSpacing: CGFloat {
        switch LocalizationSettings.shared.language {
            case .english:
                0.7
            case .arabic:
                0
        }
    }
}
