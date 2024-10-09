//
//  FontLetterSpacing.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 09/10/2024.
//

import Foundation

public extension DesignSystem.Foundation.Measurements.Font {
    static var letterSpacing: CGFloat {
        switch LanguageSettings.shared.language {
            case .english:
                0.7
            case .arabic:
                0
        }
    }
    
    static var lineSpacing: CGFloat {
        24
    }
}
