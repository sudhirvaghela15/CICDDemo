//
//  Constant.swift
//  MVVMDemo
//
//  Created by sudhir on 26/06/22.
//

import Foundation
internal enum Localization {
  /// Cancel
  internal static let cancel = Localization.tr("Localizable", "cancel")
  /// Choose option
  internal static let chooseOption = Localization.tr("Localizable", "choose-option")
  /// Confirm password
  internal static let confirmPassword = Localization.tr("Localizable", "confirm-password")
  /// Done
  internal static let done = Localization.tr("Localizable", "done")
  /// Email
  internal static let email = Localization.tr("Localizable", "email")
  /// Error
  internal static let error = Localization.tr("Localizable", "error")
  /// Home
  internal static let home = Localization.tr("Localizable", "home")
  /// Logout
  internal static let logout = Localization.tr("Localizable", "logout")
  /// Name
  internal static let name = Localization.tr("Localizable", "name")
  /// OK
  internal static let ok = Localization.tr("Localizable", "ok")
  /// Password
  internal static let password = Localization.tr("Localizable", "password")
  /// Settings
  internal static let settings = Localization.tr("Localizable", "settings")
  /// Sign In
  internal static let signIn = Localization.tr("Localizable", "sign-in")
  /// Sign Up
  internal static let signUp = Localization.tr("Localizable", "sign-up")
  /// Skip
  internal static let skip = Localization.tr("Localizable", "skip")
}



// MARK: - Implementation Details
extension Localization {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
