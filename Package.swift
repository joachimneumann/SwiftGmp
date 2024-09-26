// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "SwiftGmp",
    platforms: [
        .macOS(.v13),
        .iOS(.v17)
        ],
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
        ),
        .testTarget(
            name: "SwiftGmpTests",
            dependencies: ["SwiftGmp"]
        ),
        .testTarget(
            name: "NumberTests",
            dependencies: ["SwiftGmp"]
        ),
        .testTarget(
            name: "CommandParserTest",
            dependencies: ["SwiftGmp"]
        )
    ]
)
