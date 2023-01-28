//
//  GeneratedStrings.swift
//  ModulTechTest
//
//  Created by Fares Ben amor on 28/1/2023.
//

import Foundation
import UIKit

internal enum L10n {
    
    internal static let smartHouse = L10n.tr("Localizable", "smartHouse")
    internal static let temperature = L10n.tr("Localizable", "temperature")
    internal static let position = L10n.tr("Localizable", "position")
    internal static let mode = L10n.tr("Localizable", "mode")
    internal static let intensity = L10n.tr("Localizable", "intensity")
    internal static let openedAt = L10n.tr("Localizable", "openedAt")
    internal static let opened = L10n.tr("Localizable", "opened")
    internal static let closed = L10n.tr("Localizable", "closed")
    internal static let heater = L10n.tr("Localizable", "heater")
    internal static let rollerShutter = L10n.tr("Localizable", "rollerShutter")
    internal static let light = L10n.tr("Localizable", "light")
    internal static let error = L10n.tr("Localizable", "error")
    internal static let errorAlertMessage = L10n.tr("Localizable", "errorAlertMessage")
}

// MARK: - Implementation Details
extension L10n {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        
        let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")

        return String(format: format, locale: Locale.current, arguments: args)
    }
}

private final class BundleToken {}
