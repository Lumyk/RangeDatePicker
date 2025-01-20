// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "RangeDatePicker",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "RangeDatePicker",
            targets: ["RangeDatePicker"]),
    ],
    targets: [
        .target(
            name: "RangeDatePicker"
        ),
    ]
)
