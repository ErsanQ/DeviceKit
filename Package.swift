// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "DeviceKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7),
        .visionOS(.v1)
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
            path: "Sources/DeviceKit",
            exclude: ["Examples"]),
        .testTarget(
            name: "DeviceKitTests",
            dependencies: ["DeviceKit"],
            path: "Tests/DeviceKitTests"),
    ]
)
