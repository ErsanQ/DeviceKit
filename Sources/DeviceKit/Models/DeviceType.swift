import Foundation

public enum DeviceType: String, Sendable {
    case iPhoneX = "iPhone X"
    case iPhoneXR = "iPhone XR"
    case iPhoneXS = "iPhone XS"
    case iPhoneXSMax = "iPhone XS Max"
    case iPhone11 = "iPhone 11"
    case iPhone11Pro = "iPhone 11 Pro"
    case iPhone11ProMax = "iPhone 11 Pro Max"
    case iPhone12 = "iPhone 12"
    case iPhone12Mini = "iPhone 12 mini"
    case iPhone12Pro = "iPhone 12 Pro"
    case iPhone12ProMax = "iPhone 12 Pro Max"
    case iPhone13 = "iPhone 13"
    case iPhone13Mini = "iPhone 13 mini"
    case iPhone13Pro = "iPhone 13 Pro"
    case iPhone13ProMax = "iPhone 13 Pro Max"
    case iPhone14 = "iPhone 14"
    case iPhone14Plus = "iPhone 14 Plus"
    case iPhone14Pro = "iPhone 14 Pro"
    case iPhone15 = "iPhone 15"
    case iPhone16 = "iPhone 16"
    case iPhone17 = "iPhone 17"
    case iPhone18 = "iPhone 18"
    case unknown = "Unknown Device"

    public static func from(identifier: String) -> DeviceType {
        if identifier.contains("iPhone10,3") || identifier.contains("iPhone10,6") { return .iPhoneX }
        if identifier.contains("iPhone11,8") { return .iPhoneXR }
        if identifier.contains("iPhone11,2") { return .iPhoneXS }
        if identifier.contains("iPhone11,4") || identifier.contains("iPhone11,6") { return .iPhoneXSMax }
        if identifier.contains("iPhone12,1") { return .iPhone11 }
        if identifier.contains("iPhone12,3") { return .iPhone11Pro }
        if identifier.contains("iPhone12,5") { return .iPhone11ProMax }
        if identifier.contains("iPhone13,2") { return .iPhone12 }
        if identifier.contains("iPhone13,1") { return .iPhone12Mini }
        if identifier.contains("iPhone13,3") { return .iPhone12Pro }
        if identifier.contains("iPhone13,4") { return .iPhone12ProMax }
        if identifier.contains("iPhone14,5") { return .iPhone13 }
        if identifier.contains("iPhone14,4") { return .iPhone13Mini }
        if identifier.contains("iPhone14,2") { return .iPhone13Pro }
        if identifier.contains("iPhone14,3") { return .iPhone13ProMax }
        if identifier.contains("iPhone14,7") { return .iPhone14 }
        if identifier.contains("iPhone14,8") { return .iPhone14Plus }
        if identifier.contains("iPhone15,2") || identifier.contains("iPhone15,3") { return .iPhone14Pro }
        if identifier.hasPrefix("iPhone15,") { return .iPhone15 }
        if identifier.hasPrefix("iPhone16,") { return .iPhone16 }
        if identifier.hasPrefix("iPhone17,") { return .iPhone17 }
        if identifier.hasPrefix("iPhone18,") { return .iPhone18 }
        return .unknown
    }
}
