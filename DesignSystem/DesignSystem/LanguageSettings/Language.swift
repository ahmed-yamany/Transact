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

    public var path: String {
        // swiftlint: disable force_unwrapping
        Bundle(for: LanguageSettings.self).path(forResource: rawValue, ofType: "lproj")!
        // swiftlint: enable force_unwrapping
    }

    public var bundle: Bundle {
        // swiftlint: disable force_unwrapping
        Bundle(path: path)!
        // swiftlint: enable force_unwrapping
    }
}
