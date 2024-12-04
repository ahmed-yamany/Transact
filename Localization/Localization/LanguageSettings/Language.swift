//
//  Language.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 17/09/2024.
//

import SwiftUI

public enum Language: String, CaseIterable, Hashable {
    case english = "en"
    case arabic = "ar"

    var identifier: String {
        rawValue
    }
}

extension Language {
    public var layoutDirection: LayoutDirection {
        switch self {
        case .english:
            .leftToRight
        case .arabic:
            .rightToLeft
        }
    }

    public var local: Locale {
        Locale(identifier: rawValue)
    }

    private func path(forLocalization localization: String) -> String {
        // swiftlint: disable force_unwrapping
        Bundle(for: LocalizationSettings.self).path(forResource: rawValue, ofType: "lproj", inDirectory: nil, forLocalization: localization)!
        // swiftlint: enable force_unwrapping
    }

    public func bundle(forLocalization localization: String) -> Bundle {
        // swiftlint: disable force_unwrapping
        Bundle(path: path(forLocalization: localization))!
        // swiftlint: enable force_unwrapping
    }
}
