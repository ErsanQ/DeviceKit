// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DeviceKit",
    platforms: [
        .iOS(.v14),
        .macOS(.v11)
    ],
    products: [
        .library(
            name: "DeviceKit",
            targets: ["DeviceKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "DeviceKit",
            dependencies: [],
            path: "Sources/DeviceKit"),
        .testTarget(
            name: "DeviceKitTests",
            dependencies: ["DeviceKit"],
            path: "Tests/DeviceKitTests"),
    ]
)
