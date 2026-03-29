import SwiftUI
import DeviceKit

struct DeviceExampleView: View {
    @State private var batteryLevel: Float = 0
    @State private var batteryStatus: String = "Unknown"
    @State private var thermalStatus: String = "Nominal"
    
    var body: some View {
        List {
            Section(header: Text("Device Information")) {
                InfoRow(title: "Model Name", value: Device.current.modelName)
                InfoRow(title: "Hardware ID", value: Device.current.hardwareIdentifier)
                InfoRow(title: "Physical Type", value: Device.current.isPad ? "iPad" : "iPhone")
            }
            
            Section(header: Text("Device Status (Async)")) {
                InfoRow(title: "Battery Level", value: "\(Int(batteryLevel * 100))%")
                InfoRow(title: "Battery Status", value: batteryStatus)
                InfoRow(title: "Thermal State", value: thermalStatus)
            }
            
            Section(header: Text("Screen Capabilities")) {
                CapabilityRow(title: "Dynamic Island", has: Device.current.hasDynamicIsland)
                CapabilityRow(title: "Notch", has: Device.current.hasNotch)
                CapabilityRow(title: "Small Screen", has: Device.current.isSmallScreen)
            }
            
            Section(header: Text("Safe Area (No GeometryReader)")) {
                InfoRow(title: "Top Inset", value: "\(Int(Device.current.safeAreaInsets.top)) pt")
                InfoRow(title: "Bottom Inset", value: "\(Int(Device.current.safeAreaInsets.bottom)) pt")
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("DeviceKit Demo")
        .task {
            // Asynchronously fetch device status
            batteryLevel = await Device.current.batteryLevel()
            batteryStatus = await Device.current.batteryState()
            thermalStatus = await Device.current.thermalStatusDescription()
        }
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
    }
}

struct CapabilityRow: View {
    let title: String
    let has: Bool
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Image(systemName: has ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundColor(has ? .green : .red)
        }
    }
}

#Preview {
    NavigationView {
        DeviceExampleView()
    }
}
