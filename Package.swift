// swift-tools-version:5.4
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
      dependencies: ["bls_framework"],
      path: "bls_framework/Sources",
      exclude: [
        "bls",
        "mcl"
      ]
    ),
    .binaryTarget(
       name: "bls_framework",
       url: "https://github.com/MyEtherWallet/bls-eth-swift/releases/download/pre-1.0.1/bls_framework.xcframework.zip",
       checksum: "3a97beeccb389187128bc08fa0a6576d72ae9872dc59facef8412af5400951de"
    )
  ]
)
