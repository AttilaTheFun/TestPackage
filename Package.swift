// swift-tools-version: 6.0

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
                .swiftLanguageMode(.v6),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("InternalImportsByDefault"),
                .enableExperimentalFeature("AccessLevelOnImport")
            ]
        )
    ]
)
