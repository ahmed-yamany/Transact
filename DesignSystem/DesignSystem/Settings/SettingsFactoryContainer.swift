//
//  SettingsFactoryContainer.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 17/09/2024.
//

import SwiftUI

public struct SettingsFactoryContainer {
    private static var useCase: SettingsUseCaseProtocol = SettingsUseCase()
    @ObservedObject public static var settings = Settings(useCase: Self.useCase)
}


public extension View {
    @ViewBuilder
    func environmentSettings(_ settings: any SettingsProtocol) -> some View {
        environment(\.locale, settings.language.local)
        .environment(\.layoutDirection, settings.language.layoutDirection)
        .environment(\.language, settings.language)
        .environment(\.settings, settings)
        .id(settings.language)
    }
}

public struct EnvironmentLanguageKey: EnvironmentKey {
    public static var defaultValue: Language = .en
}

public extension EnvironmentValues {
    var language: Language {
        get { self[EnvironmentLanguageKey.self] }
        set { self[EnvironmentLanguageKey.self] = newValue }
    }
}

public struct SettingsEnvironmentKey: EnvironmentKey {
    public static var defaultValue: any SettingsProtocol = SettingsFactoryContainer.settings
}

public extension EnvironmentValues {
    var settings: any SettingsProtocol {
        get { self[SettingsEnvironmentKey.self] }
        set { self[SettingsEnvironmentKey.self] = newValue }
    }
}

