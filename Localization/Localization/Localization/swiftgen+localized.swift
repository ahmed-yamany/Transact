//
//  swiftgen+localized.swift
//  DesignSystem
//
//  Created by Ahmed Yamany on 17/09/2024.
//

import Foundation
 
func localized(forKey key: String, table: String, fallbackValue value: String) -> String {
    LocalizationSettings.shared.getLanguage().bundle(forLocalization: table).localizedString(forKey: key, value: value, table: table)
}
