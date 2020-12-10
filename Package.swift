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
       url: "https://github.com/Foboz/bls/raw/master/bls_framework.xcframework.zip",
       checksum: "2187838d3c2797153f2a2aec17177f70cd8878b3055806f3c6dda92dab6d6498"
    )
  ]
)
