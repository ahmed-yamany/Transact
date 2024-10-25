// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// and
  public static var and: String { return L10n.tr("Localizable", "and", fallback: "and") }
  /// Localizable.strings
  ///   Localization
  /// 
  ///   Created by Ahmed Yamany on 17/10/2024.
  public static var appName: String { return L10n.tr("Localizable", "app-name", fallback: "Transact") }
  /// Back
  public static var back: String { return L10n.tr("Localizable", "back", fallback: "Back") }
  /// Don’t have an account ?
  public static var dontHaveAccount: String { return L10n.tr("Localizable", "dont-have-account", fallback: "Don’t have an account ?") }
  /// Enter Password
  public static var enterPassword: String { return L10n.tr("Localizable", "enter-password", fallback: "Enter Password") }
  /// Enter PhoneNumber
  public static var enterPhoneNumber: String { return L10n.tr("Localizable", "enter-phoneNumber", fallback: "Enter PhoneNumber") }
  /// Forgot Password
  public static var forgotPassword: String { return L10n.tr("Localizable", "forgot-password", fallback: "Forgot Password") }
  /// Get Started
  public static var getStarted: String { return L10n.tr("Localizable", "get-started", fallback: "Get Started") }
  /// Login
  public static var login: String { return L10n.tr("Localizable", "login", fallback: "Login") }
  /// Next
  public static var next: String { return L10n.tr("Localizable", "next", fallback: "Next") }
  /// Password
  public static var password: String { return L10n.tr("Localizable", "password", fallback: "Password") }
  /// Phone Number
  public static var phoneNumber: String { return L10n.tr("Localizable", "phoneNumber", fallback: "Phone Number") }
  /// Privacy Policy
  public static var privacyPolicy: String { return L10n.tr("Localizable", "privacy-policy", fallback: "Privacy Policy") }
  /// Remember me
  public static var rememberMe: String { return L10n.tr("Localizable", "remember-me", fallback: "Remember me") }
  /// Restart
  public static var restart: String { return L10n.tr("Localizable", "restart", fallback: "Restart") }
  /// Sign Up
  public static var signup: String { return L10n.tr("Localizable", "signup", fallback: "Sign Up") }
  /// Skip
  public static var skip: String { return L10n.tr("Localizable", "skip", fallback: "Skip") }
  /// By clicking on ‘Next’ you’ve agreed to the
  public static var termsConditionDescription: String { return L10n.tr("Localizable", "terms-condition-description", fallback: "By clicking on ‘Next’ you’ve agreed to the") }
  /// Terms of Use
  public static var termsOfUse: String { return L10n.tr("Localizable", "terms-of-use", fallback: "Terms of Use") }
  /// Welcome Back
  public static var welcomeBack: String { return L10n.tr("Localizable", "welcome-back", fallback: "Welcome Back") }
  public enum Login {
    /// Login to easily save, recieve and send money using just your phone number
    public static var subtitle: String { return L10n.tr("Localizable", "login.subtitle", fallback: "Login to easily save, recieve and send money using just your phone number") }
  }
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
