// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "bls-eth-swift",
  platforms: [.iOS(.v11), .macOS(.v10_12), .tvOS(.v9), .watchOS(.v7)],
  products: [
    .library(name: "bls-eth-swift",
             targets: ["bls_framework"])
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "bls-eth-swift",
      dependencies: ["bls_framework"]
    ),
    .binaryTarget(
       name: "bls_framework",
       url: "https://github.com/khaninejad/bls-eth-swift/raw/34910d6cfd00ae749a1d741088482ba512e3f1fc/bls_framework.xcframework.zip"
    )
  ]
)
