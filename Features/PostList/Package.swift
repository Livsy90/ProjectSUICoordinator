// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PostList",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "PostList",
            targets: ["PostList"]),
    ],
    dependencies: [
        .package(path: "../Foundation/Router"),
    ],
    targets: [
        .target(
            name: "PostList",
            dependencies: [
                "Router"
            ]
        ),
        .testTarget(
            name: "PostListTests",
            dependencies: ["PostList"]),
    ]
)
