// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {

  internal enum AddMovie {
    /// Add New
    internal static let addNew = Strings.tr("Localizable", "AddMovie.AddNew")
    /// Change
    internal static let changeButtonTitle = Strings.tr("Localizable", "AddMovie.ChangeButtonTitle")
    /// Description
    internal static let description = Strings.tr("Localizable", "AddMovie.Description")
    /// YouTube Link
    internal static let link = Strings.tr("Localizable", "AddMovie.Link")
    /// Name
    internal static let name = Strings.tr("Localizable", "AddMovie.Name")
    /// Rating
    internal static let rating = Strings.tr("Localizable", "AddMovie.Rating")
    /// Release Date
    internal static let releaseDate = Strings.tr("Localizable", "AddMovie.ReleaseDate")
  }

  internal enum BaseChangeInfo {
    /// Release Date
    internal static let dateTitle = Strings.tr("Localizable", "BaseChangeInfo.DateTitle")
    /// Name
    internal static let linkTextFieldPlaceholder = Strings.tr("Localizable", "BaseChangeInfo.LinkTextFieldPlaceholder")
    /// YouTube Link
    internal static let linkTitleLabel = Strings.tr("Localizable", "BaseChangeInfo.LinkTitleLabel")
    /// Fill Name Field
    internal static let nameErrorMessage = Strings.tr("Localizable", "BaseChangeInfo.NameErrorMessage")
    /// Name
    internal static let nameTextFieldPlaceholder = Strings.tr("Localizable", "BaseChangeInfo.NameTextFieldPlaceholder")
    /// Movie Name
    internal static let nameTitle = Strings.tr("Localizable", "BaseChangeInfo.NameTitle")
    /// Your Rating
    internal static let ratingTitle = Strings.tr("Localizable", "BaseChangeInfo.RatingTitle")
  }

  internal enum General {
    /// Camera
    internal static let camera = Strings.tr("Localizable", "General.Camera")
    /// Cancel
    internal static let cancel = Strings.tr("Localizable", "General.Cancel")
    /// Delete
    internal static let delete = Strings.tr("Localizable", "General.Delete")
    /// Error
    internal static let error = Strings.tr("Localizable", "General.Error")
    /// OK
    internal static let ok = Strings.tr("Localizable", "General.OK")
    /// Photos
    internal static let photos = Strings.tr("Localizable", "General.Photos")
    /// Save
    internal static let save = Strings.tr("Localizable", "General.Save")
  }

  internal enum MovieList {
    /// My Movie List
    internal static let myMovieList = Strings.tr("Localizable", "MovieList.MyMovieList")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

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
