//
//  Language.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 17/09/2024.
//

import SwiftUI

public enum Language: String, CaseIterable, Hashable {
    // swiftlint: disable identifier_name
    case en
    case ar
    // swiftlint: enable identifier_name

    public var layoutDirection: LayoutDirection {
        switch self {
        case .en:
            .leftToRight
        case .ar:
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
