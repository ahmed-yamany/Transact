//
//  Settings.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 17/09/2024.
//

import SwiftUI
import Combine

public protocol SettingsProtocol: ObservableObject {
    var language: Language { get set }
}

public class Settings: SettingsProtocol {
    @Published public var language: Language = .en {
        didSet {
            useCase.updateLanguage(with: language)
        }
    }
    
    private let useCase: SettingsUseCaseProtocol
    
    init(useCase: SettingsUseCaseProtocol) {
        self.useCase = useCase
        language = useCase.getLanguage()
    }
}
