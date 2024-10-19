// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// Localizable.strings
  ///   Localization
  /// 
  ///   Created by Ahmed Yamany on 17/10/2024.
  public static var appName: String { return L10n.tr("Localizable", "app-name", fallback: "Transact") }
  /// Back
  public static var back: String { return L10n.tr("Localizable", "back", fallback: "Back") }
  /// Get Started
  public static var getStarted: String { return L10n.tr("Localizable", "get-started", fallback: "Get Started") }
  /// Next
  public static var next: String { return L10n.tr("Localizable", "next", fallback: "Next") }
  /// Restart
  public static var restart: String { return L10n.tr("Localizable", "restart", fallback: "Restart") }
  /// Skip
  public static var skip: String { return L10n.tr("Localizable", "skip", fallback: "Skip") }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = localized(forKey:table:fallbackValue:)(key, table, value)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}
