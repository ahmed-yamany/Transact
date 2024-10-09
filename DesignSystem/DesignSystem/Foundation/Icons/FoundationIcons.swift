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
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum FoundationIcons {
  public static let union2 = ImageAsset(name: "Union-2")
  public static let back = ImageAsset(name: "back")
  public static let cancel = ImageAsset(name: "cancel")
  public static let downFill = ImageAsset(name: "down-fill")
  public static let downOutline = ImageAsset(name: "down-outline")
  public static let eye = ImageAsset(name: "eye")
  public static let filter = ImageAsset(name: "filter")
  public static let help = ImageAsset(name: "help")
  public static let homeFill = ImageAsset(name: "home-fill")
  public static let homeOutline = ImageAsset(name: "home-outline")
  public static let leftFill = ImageAsset(name: "left-fill")
  public static let logout = ImageAsset(name: "logout")
  public static let notificationsFill = ImageAsset(name: "notifications-fill")
  public static let notificationsOutline = ImageAsset(name: "notifications-outline")
  public static let print = ImageAsset(name: "print")
  public static let radioActive = ImageAsset(name: "radio-active")
  public static let radio = ImageAsset(name: "radio")
  public static let recordFill = ImageAsset(name: "record-fill")
  public static let recordOutline = ImageAsset(name: "record-outline")
  public static let reload = ImageAsset(name: "reload")
  public static let save = ImageAsset(name: "save")
  public static let security = ImageAsset(name: "security")
  public static let settings = ImageAsset(name: "settings")
  public static let tickFill = ImageAsset(name: "tick-fill")
  public static let tick = ImageAsset(name: "tick")
  public static let transaction = ImageAsset(name: "transaction")
  public static let upOutline = ImageAsset(name: "up-outline")
  public static let upFill = ImageAsset(name: "up.fill")
  public static let userAccount = ImageAsset(name: "user-account")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public struct ImageAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  public var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  public func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

public extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
public extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
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
