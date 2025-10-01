// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "swift-dependency-graphs",
  platforms: [.macOS(.v10_15)],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "DependencyGraphs",
      targets: ["DependencyGraphs"])
  ],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-collections.git",
      .upToNextMinor(from: "1.2.0")
    ),
    .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", exact: "0.61.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(
      name: "DependencyGraphs",
      dependencies: [
        .product(name: "Collections", package: "swift-collections")
      ]
    ),
    .testTarget(
      name: "DependencyGraphsTests",
      dependencies: ["DependencyGraphs"]
    ),
  ]
)
