//
//  Typography+FontConvertible.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 09/10/2024.
//

import Foundation
import Localization

public extension DesignSystem.Foundation.Typography {
    static var regular: FontConvertible {
        switch LocalizationSettings.shared.getLanguage() {
        case .english:
            FontFamily.Inter.regular
        case .arabic:
            FontFamily.Cairo.regular
        }
    }

    static var black: FontConvertible {
        switch LocalizationSettings.shared.getLanguage() {
        case .english:
            FontFamily.Inter.black
        case .arabic:
            FontFamily.Cairo.black
        }
    }

    static var bold: FontConvertible {
        switch LocalizationSettings.shared.getLanguage() {
        case .english:
            FontFamily.Inter.bold
        case .arabic:
            FontFamily.Cairo.bold
        }
    }

    static var extraBold: FontConvertible {
        switch LocalizationSettings.shared.getLanguage() {
        case .english:
            FontFamily.Inter.extraBold
        case .arabic:
            FontFamily.Cairo.extraBold
        }
    }

    static var extraLight: FontConvertible {
        switch LocalizationSettings.shared.getLanguage() {
        case .english:
            FontFamily.Inter.extraLight
        case .arabic:
            FontFamily.Cairo.extraLight
        }
    }

    static var light: FontConvertible {
        switch LocalizationSettings.shared.getLanguage() {
        case .english:
            FontFamily.Inter.light
        case .arabic:
            FontFamily.Cairo.light
        }
    }

    static var medium: FontConvertible {
        switch LocalizationSettings.shared.getLanguage() {
        case .english:
            FontFamily.Inter.medium
        case .arabic:
            FontFamily.Cairo.medium
        }
    }

    static var semiBold: FontConvertible {
        switch LocalizationSettings.shared.getLanguage() {
        case .english:
            FontFamily.Inter.semiBold
        case .arabic:
            FontFamily.Cairo.semiBold
        }
    }
}
