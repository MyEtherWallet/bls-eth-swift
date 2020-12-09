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
       checksum: "5867d6336431d41135dc55ef753e940ef6762995ce1faef5ca4398e06bf2e9d6"
    )
  ]
)
