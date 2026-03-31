import Foundation

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// A comprehensive utility for identifying Apple hardware and screen characteristics.
///
/// `Device` provides a unified interface to access hardware identifiers, model names,
/// and specific UI-affecting features like notches or dynamic islands.
///
/// ## Usage
/// ```swift
/// if Device.current.hasDynamicIsland {
///     showIslandSpecificUI()
/// }
/// ```
public struct Device: Sendable {
    
    /// The shared instance representing the hardware currently running the code.
    public static let current = Device()
    
    private init() {}
    
    /// The user-visible name of the device model (e.g., "iPhone 16 Pro Max").
    ///
    /// This property maps internal hardware identifiers to friendly names.
    public var modelName: String {
        let identifier = hardwareIdentifier
        return DeviceType.from(identifier: identifier).rawValue
    }
    
    /// A boolean value indicating whether the current device is an iPad.
    public var isPad: Bool {
        #if os(iOS)
        return UIDevice.current.userInterfaceIdiom == .pad
        #else
        return false
        #endif
    }
    
    /// A boolean value indicating whether the device features a display notch.
    ///
    /// This includes iPhone X through iPhone 14 (excluding Dynamic Island models).
    public var hasNotch: Bool {
        let type = DeviceType.from(identifier: hardwareIdentifier)
        switch type {
        case .iPhoneX, .iPhoneXR, .iPhoneXS, .iPhoneXSMax,
             .iPhone11, .iPhone11Pro, .iPhone11ProMax,
             .iPhone12, .iPhone12Mini, .iPhone12Pro, .iPhone12ProMax,
             .iPhone13, .iPhone13Mini, .iPhone13Pro, .iPhone13ProMax,
             .iPhone14, .iPhone14Plus:
            return true
        default:
            return false
        }
    }
    
    /// A boolean value indicating whether the device features a Dynamic Island.
    ///
    /// This includes iPhone 14 Pro, all iPhone 15 models, and all subsequent models.
    public var hasDynamicIsland: Bool {
        let type = DeviceType.from(identifier: hardwareIdentifier)
        switch type {
        case .iPhone14Pro, .iPhone15, .iPhone16, .iPhone17, .iPhone18:
            return true
        default:
            let raw = type.rawValue
            return raw.contains("iPhone 15") || raw.contains("iPhone 16") || raw.contains("iPhone 17") || raw.contains("14 Pro")
        }
    }
    
    /// A boolean value indicating whether the device has a small form factor screen.
    ///
    /// This covers "Mini", "SE", and legacy 4.7-inch models.
    public var isSmallScreen: Bool {
        let raw = modelName
        return raw.contains("Mini") || raw.contains("SE") || raw.contains("8")
    }
    
    /// The raw internal hardware identifier (e.g., "iPhone16,1").
    ///
    /// This value is retrieved directly from the system's `utsname` structure.
    public var hardwareIdentifier: String {
        #if os(iOS) || os(macOS) || os(tvOS) || os(watchOS) || os(visionOS)
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        return machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        #else
        return "Unknown"
        #endif
    }
}
