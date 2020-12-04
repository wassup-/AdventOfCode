// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdventOfCode 2020",
    products: [
        .executable(name: "Day 1", targets: ["Day 1"]),
        .executable(name: "Day 2", targets: ["Day 2"]),
        .executable(name: "Day 3", targets: ["Day 3"]),
        .executable(name: "Day 4", targets: ["Day 4"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(path: "../Core"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat.git", from: "0.35.8"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Day 1",
            dependencies: ["Core"]
        ),
        .target(
            name: "Day 2",
            dependencies: ["Core"]
        ),
        .target(
            name: "Day 3",
            dependencies: ["Core"]
        ),
        .target(
            name: "Day 4",
            dependencies: ["Core"]
        ),
    ]
)
