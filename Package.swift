// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NFTStorageSwift",
    platforms: [
      .macOS(.v10_12), .iOS(.v9)
    ],
    products: [
        .library(
            name: "NFTStorageSwift",
            targets: ["NFTStorageSwift"]),
    ],
    targets: [
        
        .target(name: "NFTStorageSwift"),
        .testTarget(name: "NFTStorageSwiftTests",dependencies: ["NFTStorageSwift"]),
    ]
)
