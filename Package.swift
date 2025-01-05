// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "TestPackage",
    products: [
        .library(
            name: "TestPackage",
            targets: ["TestPackage"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "TestPackage",
            path: "Sources",
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny"),
                .enableExperimentalFeature("AccessLevelOnImport")
            ]
        )
    ]
)
