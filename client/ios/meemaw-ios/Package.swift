// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "meemaw-ios",
    platforms: [
        SupportedPlatform.iOS(.v13),
        SupportedPlatform.macOS(.v11)
    ],
    products: [
        .library(
            name: "meemaw-ios",
            targets: ["meemaw-ios"]),
    ],
    dependencies: [
        .package(url: "https://github.com/argentlabs/web3.swift", from: "1.1.0")
    ],
    targets: [
        .target(
            name: "meemaw-ios",
            dependencies: [.target(name: "Tsslib"), "web3.swift"]),
        .binaryTarget(
            name: "Tsslib",
            url: "https://github.com/getmeemaw/meemaw/releases/download/v0.1.0/Tsslib.xcframework.zip";
            path: "./Sources/Tsslib.xcframework") // replace by url & checksum once hosted online generated by github actions
    ]
)
