// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SMKeyboardObserber",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "SMKeyboardObserber",
            targets: ["SMKeyboardObserber"]),
    ],
    targets: [
        .target(
            name: "SMKeyboardObserber",
            path: "SMKeyboardObserber/Sources"),
        .testTarget(
            name: "SMKeyboardObserberTests",
            dependencies: ["SMKeyboardObserber"],
            path: "SMKeyboardObserber/Tests")
    ],
    swiftLanguageVersions: [.v5]
)
