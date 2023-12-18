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
            targets: ["AoC2023"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.2.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AoC2023",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
            ],
            resources: [
                .copy("Day14/Resources/Day14.txt"),
                .copy("Day13/Resources/Day13.txt"),
                .copy("Day12/Resources/Day12.txt"),
                .copy("Day11/Resources/Day11.txt"),
                .copy("Day10/Resources/Day10.txt"),
                .copy("Day9/Resources/Day9.txt"),
                .copy("Day8/Resources/Day8.txt"),
                .copy("Day7/Resources/Day7.txt"),
                .copy("Day6/Resources/Day6.txt"),
                .copy("Day5/Resources/Day5.txt"),
                .copy("Day4/Resources/Day4.txt"),
                .copy("Day3/Resources/Day3.txt"),
                .copy("Day2/Resources/Day2.txt"),
                .copy("Day1/Resources/Day1.txt"),
            ]
        ),
        .testTarget(
            name: "AoC2023Tests",
            dependencies: ["AoC2023"]),
    ]
)














