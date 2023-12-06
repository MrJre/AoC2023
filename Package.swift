// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AoC2023",
    platforms: [.macOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AoC2023",
            targets: ["AoC2023"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AoC2023",
            resources: [
                .copy("Day5/Resources/Day5.txt"),
                .copy("Day4/Resources/Day4.txt"),
                .copy("Day3/Resources/Day3.txt"),
                .copy("Day2/Resources/Day2.txt"),
                .copy("Day1/Resources/Day1.txt"),
            ]),
        .testTarget(
            name: "AoC2023Tests",
            dependencies: ["AoC2023"]),
    ]
)







