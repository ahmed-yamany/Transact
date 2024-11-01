// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// Already have an account ?
  public static var alreadyHaveAccount: String { return L10n.tr("Localizable", "already-have-account", fallback: "Already have an account ?") }
  /// and
  public static var and: String { return L10n.tr("Localizable", "and", fallback: "and") }
  /// Localizable.strings
  ///   Localization
  /// 
  ///   Created by Ahmed Yamany on 17/10/2024.
  public static var appName: String { return L10n.tr("Localizable", "app-name", fallback: "Transact") }
  /// Back
  public static var back: String { return L10n.tr("Localizable", "back", fallback: "Back") }
  /// Change Password
  public static var changePassword: String { return L10n.tr("Localizable", "change-password", fallback: "Change Password") }
  /// Don’t have an account ?
  public static var dontHaveAccount: String { return L10n.tr("Localizable", "dont-have-account", fallback: "Don’t have an account ?") }
  /// Enter Password
  public static var enterPassword: String { return L10n.tr("Localizable", "enter-password", fallback: "Enter Password") }
  /// Enter PhoneNumber
  public static var enterPhoneNumber: String { return L10n.tr("Localizable", "enter-phoneNumber", fallback: "Enter PhoneNumber") }
  /// Enter Your Full Name
  public static var enterYourFullName: String { return L10n.tr("Localizable", "enter-your-full-name", fallback: "Enter Your Full Name") }
  /// Forgot Password
  public static var forgotPassword: String { return L10n.tr("Localizable", "forgot-password", fallback: "Forgot Password") }
  /// Full Name
  public static var fullName: String { return L10n.tr("Localizable", "full-name", fallback: "Full Name") }
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
  /// Resend Code
  public static var resendCode: String { return L10n.tr("Localizable", "resend-code", fallback: "Resend Code") }
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
  /// Verify
  public static var verify: String { return L10n.tr("Localizable", "verify", fallback: "Verify") }
  /// Welcome Back
  public static var welcomeBack: String { return L10n.tr("Localizable", "welcome-back", fallback: "Welcome Back") }
  /// Welcome To Transact
  public static var welcomeToTransact: String { return L10n.tr("Localizable", "welcome-to-transact", fallback: "Welcome To Transact") }
  public enum Error {
    /// Phone Number shouldn't be empty
    public static var emptyPhoneNumber: String { return L10n.tr("Localizable", "error.empty-phoneNumber", fallback: "Phone Number shouldn't be empty") }
    /// Full Name length shouldn't be less than 3 chrachters
    public static var fullNameLength: String { return L10n.tr("Localizable", "error.fullName-length", fallback: "Full Name length shouldn't be less than 3 chrachters") }
    /// Phone Number shouldn't contain invalid charachters
    public static var phoneNumberInvalidCharachters: String { return L10n.tr("Localizable", "error.phoneNumber-invalid-charachters", fallback: "Phone Number shouldn't contain invalid charachters") }
    /// Phone Number length shouldn't be empty less than 11
    public static var phoneNumberLength: String { return L10n.tr("Localizable", "error.phoneNumber-length", fallback: "Phone Number length shouldn't be empty less than 11") }
  }
  public enum ForgotPassword {
    /// Please provide your phone number and change a new password
    public static var subtitle: String { return L10n.tr("Localizable", "forgotPassword.subtitle", fallback: "Please provide your phone number and change a new password") }
  }
  public enum Login {
    /// Login to easily save, recieve and send money using just your phone number
    public static var subtitle: String { return L10n.tr("Localizable", "login.subtitle", fallback: "Login to easily save, recieve and send money using just your phone number") }
  }
  public enum Signup {
    /// Register to easily save, recieve and send money using just your phone number
    public static var subtitle: String { return L10n.tr("Localizable", "signup.subtitle", fallback: "Register to easily save, recieve and send money using just your phone number") }
    public enum Otp {
      /// OTP has been Sent to your phone number %s.  The code expires in %s
      public static func subtitle(_ p1: UnsafePointer<CChar>, _ p2: UnsafePointer<CChar>) -> String {
        return L10n.tr("Localizable", "signup.otp.subtitle", p1, p2, fallback: "OTP has been Sent to your phone number %s.  The code expires in %s")
      }
      /// Please verify your Phone Number
      public static var title: String { return L10n.tr("Localizable", "signup.otp.title", fallback: "Please verify your Phone Number") }
    }
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
