// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Sources",
    defaultLocalization: "ru",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Sources",
            targets: ["Core"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
              name: "Core",
              dependencies: [
                "ProductsList",
                "ShoppingCart",
                "AppInfo",
                "UIComponents"
              ]
        ),
        .target(
            name: "ProductsList",
            dependencies: [
                "ArchComponents",
                "UIComponents",
                "Networking"
        ]),
        .target(
            name: "ShoppingCart",
            dependencies: [
                "ArchComponents",
        ]),
        .target(
            name: "AppInfo",
            dependencies: [
                "ArchComponents",
        ]),
        .target(
            name: "ArchComponents",
            dependencies: []
        ),
        .target(
            name: "UIComponents",
            dependencies: []
        ),
        .target(
            name: "Networking",
            dependencies: []
        ),
        .testTarget(
            name: "SourcesTests",
            dependencies: ["Core"]),
    ]
)
