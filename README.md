![GitHub](https://img.shields.io/github/license/MyEtherWallet/bls-eth-swift?colorA=07A6B3&&colorB=5F6368)
[![Platform](https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS-5F6368.svg?colorA=07A6B3)](#installation)
[![Swift support](https://img.shields.io/badge/Swift-5.0-lightgrey.svg?colorA=07A6B3&colorB=5F6368)](#swift-versions-support)
[![Swift Package Manager compatible](https://img.shields.io/badge/SPM-compatible-brightgreen.svg?style=flat&colorA=07A6B3&&colorB=5F6368)](https://github.com/apple/swift-package-manager)

**Note**: this framework doesn't provide a way to derive Eth2 secret key ([eip-2333](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-2333.md)). Please use your own implementation

## bls-eth-swift

bls-eth-swift provides convenient way to integrate https://github.com/herumi/bls-eth-go-binary

## Requirements
Good mood

## Features
- Easy to use
- Precompiled sources

## Installation
### Swift Package Manager

You can use [Swift Package Manager](https://swift.org/package-manager/) and specify dependency in `Package.swift` by adding this:

```swift
.package(url: "https://github.com/MyEtherWallet/bls-eth-swift.git", .upToNextMajor(from: "1.0.0"))
```

### XCFramework

`XCFrameworks` require Xcode 11 or later and they can be integrated similarly to how we’re used to integrating the `.framework` format. Please use a script `bls_framework/build.sh` to generate binary `bls_framework.xcframework` archive that you can use as a dependency in Xcode or you can use precompiled one.

`bls_framework.xcframework` is a Release (Optimized) binary that offer best available Swift code performance.

## How to
```swift
import bls_framework
```

##### blsSecretKey
```swift
try BLSInterface.blsInit()

let serializedSecretKey = Data(hex: "455c0dc9fccb3395825d92a60d2672d69416be1c2578a87a7a3d3ced11ebb88d").bytes // [UInt8]

var secretKey = blsSecretKey.init()
blsSecretKeyDeserialize(&secretKey, &serializedSecretKey, numericCast(serializedSecretKey.count))
```

##### blsPublicKey
```swift
var publicKey = blsPublicKey.init()
blsGetPublicKey(&publicKey, &secretKey)
```

##### Eth2 Public Key
```swift
var publicKeyBytes = Data(count: 1024).bytes // [UInt8]
blsPublicKeySerialize(&publicKeyBytes, 1024, &publicKey)

return Data(publicKeyBytes[0..<48])
```

## Swift versions support

- Swift 5.0 and newer, branch [master](https://github.com/MyEtherWallet/bls-eth-swift/tree/master)

### License

MIT
