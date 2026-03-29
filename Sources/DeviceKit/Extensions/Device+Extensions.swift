import Foundation
import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

public extension Device {
    
    // MARK: - Battery
    
    /// Returns the current battery level of the device asynchronously.
    /// - Returns: A float between 0.0 and 1.0. 
    @MainActor
    func batteryLevel() async -> Float {
        #if os(iOS)
        UIDevice.current.isBatteryMonitoringEnabled = true
        return UIDevice.current.batteryLevel
        #else
        return 1.0
        #endif
    }
    
    /// Returns the current battery state (charging, full, unplugged, unknown).
    @MainActor
    func batteryState() async -> String {
        #if os(iOS)
        UIDevice.current.isBatteryMonitoringEnabled = true
        switch UIDevice.current.batteryState {
        case .charging: return "Charging"
        case .full: return "Full"
        case .unplugged: return "Unplugged"
        case .unknown: return "Unknown"
        @unknown default: return "Unknown"
        }
        #else
        return "N/A"
        #endif
    }
    
    // MARK: - Thermal Status
    
    /// Returns the thermal state of the device asynchronously.
    func thermalState() async -> ProcessInfo.ThermalState {
        return ProcessInfo.processInfo.thermalState
    }
    
    /// A human-readable description of the thermal status.
    func thermalStatusDescription() async -> String {
        let state = await thermalState()
        switch state {
        case .nominal: return "Nominal"
        case .fair: return "Fair"
        case .serious: return "Serious"
        case .critical: return "Critical"
        @unknown default: return "Unknown"
        }
    }
    
    // MARK: - Safe Area Insets (Without GeometryReader)
    
    /// Returns the current safe area insets of the main window.
    @MainActor
    var safeAreaInsets: EdgeInsets {
        #if os(iOS)
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first { $0.activationState == .foregroundActive } as? UIWindowScene
        let window = windowScene?.windows.first { $0.isKeyWindow } ?? UIApplication.shared.windows.first
        
        let insets = window?.safeAreaInsets ?? .zero
        return EdgeInsets(top: insets.top, leading: insets.left, bottom: insets.bottom, trailing: insets.right)
        #else
        return EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        #endif
    }
}
