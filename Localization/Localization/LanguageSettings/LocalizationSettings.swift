//
//  Settings.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 17/09/2024.
//

import SwiftUI
import Combine
import FoundationExtensions

public extension UserDefaultsKeys {
    var appLanguage: String { "App_Language" }
}

public protocol LocalizationSettingsProtocol: ObservableObject {
    var language: Language { get set }
}

public class LocalizationSettings: LocalizationSettingsProtocol {
    @ObservedObject public static var shared = LocalizationSettings()
    
    @Published public var language: Language = .english {
        didSet {
            storedLanguage = language.rawValue
        }
    }
    
    @UserDefault(key: \.appLanguage) private var storedLanguage: String?
    
    private init() {
        language = Language(rawValue: storedLanguage ?? Language.english.rawValue) ?? .english
    }
}
