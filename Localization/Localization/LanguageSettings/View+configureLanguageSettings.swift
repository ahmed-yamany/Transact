//
//  View+configureLanguageSettings.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 20/09/2024.
//

import SwiftUI

public extension View {
    @ViewBuilder
    func configureLanguageSettings(_ settings: any LocalizationSettingsProtocol = LocalizationSettings.shared) -> some View {
        environment(\.locale, settings.language.local)
        .environment(\.layoutDirection, settings.language.layoutDirection)
        .environment(\.language, settings.language)
        .environment(\.languageSettings, settings)
        .id(settings.language) // It ensures that the view gets a unique identity based on the language.
        // If the language changes, the view will be re-created with the new language settings, ensuring UI updates accordingly.
    }
}
