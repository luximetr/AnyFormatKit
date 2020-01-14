// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "AnyFormatKit",
    platforms: [.iOS(.v10)],
    products: [
        .library(
            name: "AnyFormatKit",
            targets: ["AnyFormatKit"]
        )
    ],
    targets: [
        .target(
            name: "AnyFormatKit",
            path: "Source"
        ),
        .testTarget(
            name: "AnyFormatKitTests",
            dependencies: ["AnyFormatKit"],
            path: "Tests"
        )
    ]
)
