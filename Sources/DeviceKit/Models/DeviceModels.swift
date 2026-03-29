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
            // Check if model name contains Pro/Max for 14, or 15/16/17 series
            let raw = type.rawValue
            return raw.contains("iPhone 15") || raw.contains("iPhone 16") || raw.contains("iPhone 17") || raw.contains("14 Pro")
        }
    }
    
    /// A boolean value indicating whether the device has a small screen (e.g., SE, Mini).
    public var isSmallScreen: Bool {
        let type = DeviceType.from(identifier: hardwareIdentifier)
        let raw = type.rawValue
        return raw.contains("Mini") || raw.contains("SE") || raw.contains("8")
    }
    
    /// The raw hardware identifier (e.g., "iPhone16,1").
    public var hardwareIdentifier: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        return machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
    }
}

/// A comprehensive enum representing modern iPhone and iPad models.
public enum DeviceType: String, CaseIterable, Sendable {
    case iPhone8 = "iPhone 8"
    case iPhone8Plus = "iPhone 8 Plus"
    case iPhoneX = "iPhone X"
    case iPhoneXR = "iPhone XR"
    case iPhoneXS = "iPhone XS"
    case iPhoneXSMax = "iPhone XS Max"
    case iPhone11 = "iPhone 11"
    case iPhone11Pro = "iPhone 11 Pro"
    case iPhone11ProMax = "iPhone 11 Pro Max"
    case iPhoneSE2 = "iPhone SE (2nd gen)"
    case iPhone12Mini = "iPhone 12 Mini"
    case iPhone12 = "iPhone 12"
    case iPhone12Pro = "iPhone 12 Pro"
    case iPhone12ProMax = "iPhone 12 Pro Max"
    case iPhone13Mini = "iPhone 13 Mini"
    case iPhone13 = "iPhone 13"
    case iPhone13Pro = "iPhone 13 Pro"
    case iPhone13ProMax = "iPhone 13 Pro Max"
    case iPhoneSE3 = "iPhone SE (3rd gen)"
    case iPhone14 = "iPhone 14"
    case iPhone14Plus = "iPhone 14 Plus"
    case iPhone14Pro = "iPhone 14 Pro"
    case iPhone14ProMax = "iPhone 14 Pro Max"
    case iPhone15 = "iPhone 15"
    case iPhone15Plus = "iPhone 15 Plus"
    case iPhone15Pro = "iPhone 15 Pro"
    case iPhone15ProMax = "iPhone 15 Pro Max"
    case iPhone16 = "iPhone 16"
    case iPhone16Plus = "iPhone 16 Plus"
    case iPhone16Pro = "iPhone 16 Pro"
    case iPhone16ProMax = "iPhone 16 Pro Max"
    case iPhone17 = "iPhone 17"
    case iPhone17Pro = "iPhone 17 Pro"
    case iPhone18 = "iPhone 18"
    
    case iPad = "iPad"
    case iPadMini = "iPad Mini"
    case iPadAir = "iPad Air"
    case iPadPro = "iPad Pro"
    
    case simulator = "Simulator"
    case unknown = "Unknown"
    
    static func from(identifier: String) -> DeviceType {
        switch identifier {
        case "iPhone10,1", "iPhone10,4": return .iPhone8
        case "iPhone10,2", "iPhone10,5": return .iPhone8Plus
        case "iPhone10,3", "iPhone10,6": return .iPhoneX
        case "iPhone11,2": return .iPhoneXS
        case "iPhone11,4", "iPhone11,6": return .iPhoneXSMax
        case "iPhone11,8": return .iPhoneXR
        case "iPhone12,1": return .iPhone11
        case "iPhone12,3": return .iPhone11Pro
        case "iPhone12,5": return .iPhone11ProMax
        case "iPhone12,8": return .iPhoneSE2
        case "iPhone13,1": return .iPhone12Mini
        case "iPhone13,2": return .iPhone12
        case "iPhone13,3": return .iPhone12Pro
        case "iPhone13,4": return .iPhone12ProMax
        case "iPhone14,4": return .iPhone13Mini
        case "iPhone14,5": return .iPhone13
        case "iPhone14,2": return .iPhone13Pro
        case "iPhone14,3": return .iPhone13ProMax
        case "iPhone14,6": return .iPhoneSE3
        case "iPhone14,7": return .iPhone14
        case "iPhone14,8": return .iPhone14Plus
        case "iPhone15,2": return .iPhone14Pro
        case "iPhone15,3": return .iPhone14ProMax
        case "iPhone15,4": return .iPhone15
        case "iPhone15,5": return .iPhone15Plus
        case "iPhone16,1": return .iPhone15Pro
        case "iPhone16,2": return .iPhone15ProMax
        case "iPhone17,1": return .iPhone16
        case "iPhone17,2": return .iPhone16Plus
        case "iPhone17,3": return .iPhone16Pro
        case "iPhone17,4": return .iPhone16ProMax
        case "iPhone18,1", "iPhone18,2": return .iPhone17
        case "iPhone18,3", "iPhone18,4": return .iPhone17Pro
        case "iPhone19,1": return .iPhone18
        case "i386", "x86_64", "arm64": return .simulator
        default:
            if identifier.starts(with: "iPhone") { return .iPhone18 }
            if identifier.starts(with: "iPad") { return .iPad }
            return .unknown
        }
    }
}
