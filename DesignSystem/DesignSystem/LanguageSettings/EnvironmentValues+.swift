//
//  EnvironmentValues.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 20/09/2024.
//

import SwiftUI

public struct EnvironmentLanguageKey: EnvironmentKey {
    public static var defaultValue: Language = .english
}

public extension EnvironmentValues {
    var language: Language {
        get { self[EnvironmentLanguageKey.self] }
        set { self[EnvironmentLanguageKey.self] = newValue }
    }
}

public struct SettingsEnvironmentKey: EnvironmentKey {
    public static var defaultValue: any LanguageSettingsProtocol = LanguageSettings.shared
}

public extension EnvironmentValues {
    var settings: any LanguageSettingsProtocol {
        get { self[SettingsEnvironmentKey.self] }
        set { self[SettingsEnvironmentKey.self] = newValue }
    }
}
