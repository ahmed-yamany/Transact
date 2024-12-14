//
//  Settings.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 17/09/2024.
//

import Combine
import SwiftUI

public extension UserDefaultsKeys {
    var appLanguage: String { "App_Language" }
}

public protocol LocalizationSettingsProtocol: ObservableObject {
    var language: Language { get set }
    func getLanguage() -> Language
    func setLanguage(_ language: Language)
}

public final class LocalizationSettings: LocalizationSettingsProtocol {
    @ObservedObject public static var shared = LocalizationSettings()
    private let lock = NSLock()

    @Published public var language: Language = .english {
        didSet {
            storedLanguage = language.rawValue
        }
    }

    @UserDefault(key: \.appLanguage) private var storedLanguage: String?

    private init() {
        language = Language(rawValue: storedLanguage ?? Language.english.rawValue) ?? .english
    }

    public func getLanguage() -> Language {
        lock.lock()
        defer { lock.unlock() }
        return language
    }
    
    public func setLanguage(_ language: Language) {
        lock.lock()
        defer { lock.unlock() }
        self.language = language
    }
}
