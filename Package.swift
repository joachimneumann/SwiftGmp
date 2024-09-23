// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftGmp",
    products: [
        .library(
            name: "SwiftGmp",
            targets: ["SwiftGmp", "MyCTarget"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "swiftgmp",
            path: "./swiftgmp.xcframework"
        ),
        .target(
            name: "SwiftGmp",
            dependencies: ["swiftgmp", "MyCTarget"]
        ),
        .target(
            name: "MyCTarget",
            dependencies: [],
            path: "Sources/MyCTarget",
            publicHeadersPath: "include"
        )
    ]
)
