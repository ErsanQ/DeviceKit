import Foundation

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// The current status of the hardware device.
public struct Device: Sendable {
    
    /// The shared instance of the current device.
    public static let current = Device()
    
    private init() {}
    
    /// The user-visible name of the device model (e.g., "iPhone 16 Pro Max").
    public var modelName: String {
        let identifier = hardwareIdentifier
        return DeviceType.from(identifier: identifier).rawValue
    }
    
    /// A boolean value indicating whether the device is an iPad.
    public var isPad: Bool {
        #if os(iOS)
        return UIDevice.current.userInterfaceIdiom == .pad
        #else
        return false
        #endif
    }
    
    /// A boolean value indicating whether the device has a Notch.
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
    
    /// A boolean value indicating whether the device has a Dynamic Island.
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
    
    /// A boolean value indicating whether the device has a small screen (e.g., SE, Mini).
    public var isSmallScreen: Bool {
        let raw = modelName
        return raw.contains("Mini") || raw.contains("SE") || raw.contains("8")
    }
    
    /// The raw hardware identifier (e.g., "iPhone16,1").
    public var hardwareIdentifier: String {
        #if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)
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
