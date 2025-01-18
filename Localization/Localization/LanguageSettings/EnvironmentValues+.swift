//
//  EnvironmentValues.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 20/09/2024.
//

import SwiftUI

public struct EnvironmentLanguageKey: EnvironmentKey {
    public static var defaultValue: Language = LocalizationSettings.shared.getLanguage()
}

public extension EnvironmentValues {
    var language: Language {
        get { self[EnvironmentLanguageKey.self] }
        set {
            self[EnvironmentLanguageKey.self] = newValue
        }
    }
}

public struct LanguageSettingsEnvironmentKey: EnvironmentKey {
    public static var defaultValue: any LocalizationSettingsProtocol = LocalizationSettings.shared
}

public extension EnvironmentValues {
    var languageSettings: any LocalizationSettingsProtocol {
        get { self[LanguageSettingsEnvironmentKey.self] }
        set { self[LanguageSettingsEnvironmentKey.self] = newValue }
    }
}
