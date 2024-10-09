// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum FoundationColors {
  public static let blueDarkActive = ColorAsset(name: "Blue Dark Active")
  public static let blueDarkHover = ColorAsset(name: "Blue Dark Hover")
  public static let blueDark = ColorAsset(name: "Blue Dark")
  public static let blueDarker = ColorAsset(name: "Blue Darker")
  public static let blueLightActive = ColorAsset(name: "Blue Light Active")
  public static let blueLightHover = ColorAsset(name: "Blue Light Hover")
  public static let blueLight = ColorAsset(name: "Blue Light")
  public static let blueNormalActive = ColorAsset(name: "Blue Normal Active")
  public static let blueNormalHover = ColorAsset(name: "Blue Normal Hover")
  public static let blueNormal = ColorAsset(name: "Blue Normal")
  public static let greenDarkActive = ColorAsset(name: "Green Dark Active")
  public static let greenDarkHover = ColorAsset(name: "Green Dark Hover")
  public static let greenDark = ColorAsset(name: "Green Dark")
  public static let greenDarker = ColorAsset(name: "Green Darker")
  public static let greenLightActive = ColorAsset(name: "Green Light Active")
  public static let greenLightHover = ColorAsset(name: "Green Light Hover")
  public static let greenLight = ColorAsset(name: "Green Light")
  public static let greenNormalActive = ColorAsset(name: "Green Normal Active")
  public static let greenNormalHover = ColorAsset(name: "Green Normal Hover")
  public static let greenNormal = ColorAsset(name: "Green Normal")
  public static let cloudDarkActive = ColorAsset(name: "Cloud Dark Active")
  public static let cloudDarkHover = ColorAsset(name: "Cloud Dark Hover")
  public static let cloudDark = ColorAsset(name: "Cloud Dark")
  public static let cloudLightActive = ColorAsset(name: "Cloud Light Active")
  public static let cloudLightHover = ColorAsset(name: "Cloud Light Hover")
  public static let cloudLight = ColorAsset(name: "Cloud Light")
  public static let cloudNormalActive = ColorAsset(name: "Cloud Normal Active")
  public static let cloudNormalHover = ColorAsset(name: "Cloud Normal Hover")
  public static let cloudNormal = ColorAsset(name: "Cloud Normal")
  public static let orangeDarkActive = ColorAsset(name: "Orange Dark Active")
  public static let orangeDarkHover = ColorAsset(name: "Orange Dark Hover")
  public static let orangeDark = ColorAsset(name: "Orange Dark")
  public static let orangeDarker = ColorAsset(name: "Orange Darker")
  public static let orangeLightActive = ColorAsset(name: "Orange Light Active")
  public static let orangeLightHover = ColorAsset(name: "Orange Light Hover")
  public static let orangeLight = ColorAsset(name: "Orange Light")
  public static let orangeNormalActive = ColorAsset(name: "Orange Normal Active")
  public static let orangeNormalHover = ColorAsset(name: "Orange Normal Hover")
  public static let orangeNormal = ColorAsset(name: "Orange Normal")
  public static let redDarkActive = ColorAsset(name: "Red Dark Active")
  public static let redDarkHover = ColorAsset(name: "Red Dark Hover")
  public static let redDark = ColorAsset(name: "Red Dark")
  public static let redDarker = ColorAsset(name: "Red Darker")
  public static let redLightActive = ColorAsset(name: "Red Light Active")
  public static let redLightHover = ColorAsset(name: "Red Light Hover")
  public static let redLight = ColorAsset(name: "Red Light")
  public static let redNormalActive = ColorAsset(name: "Red Normal Active")
  public static let redNormalHover = ColorAsset(name: "Red Normal Hover")
  public static let redNormal = ColorAsset(name: "Red Normal")
  public static let whiteActive = ColorAsset(name: "White Active")
  public static let whiteDarker = ColorAsset(name: "White Darker")
  public static let whiteHover = ColorAsset(name: "White Hover")
  public static let whiteLighter = ColorAsset(name: "White Lighter")
  public static let whiteNormal = ColorAsset(name: "White Normal")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class ColorAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  public func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
