// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftGmp",
    products: [
        .library(
            name: "SwiftGmp",
            targets: ["SwiftGmp", "SwiftGmp_C_Target"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "swiftgmp",
            path: "./swiftgmp.xcframework"
        ),
        .target(
            name: "SwiftGmp",
            dependencies: ["swiftgmp", "SwiftGmp_C_Target"]
        ),
        .target(
            name: "SwiftGmp_C_Target",
            dependencies: [],
            path: "Sources/SwiftGmp_C_Target",
            publicHeadersPath: "include"
        )
    ]
)
