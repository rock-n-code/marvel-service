// swift-tools-version: 5.10

// ===----------------------------------------------------------------------===
// 
// This source file is part of the Marvel Service open source project
// 
// Copyright (c) 2025 Röck+Cöde VoF. and the Marvel Service project authors
// Licensed under Apache license v2.0
// 
// See LICENSE for license information
// See CONTRIBUTORS for the list of Marvel Service project authors
//
// SPDX-License-Identifier: Apache-2.0
// 
// ===----------------------------------------------------------------------===

import PackageDescription

let package = Package(
    name: MarvelService.package,
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .visionOS(.v1),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: MarvelService.package,
            targets: [MarvelService.target]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-crypto.git", from: "3.13.0"),
        .package(url: "https://github.com/apple/swift-openapi-generator.git", from: "1.3.0"),
        .package(url: "https://github.com/apple/swift-openapi-runtime", from: "1.5.0"),
        .package(url: "https://github.com/apple/swift-openapi-urlsession", from: "1.0.2"),
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.1.0")
    ],
    targets: [
        .target(
            name: MarvelService.target,
            dependencies: [
                .product(name: "Crypto", package: "swift-crypto", condition: .when(platforms: [
                    .android, .linux, .openbsd, .windows
                ])),
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession")
            ],
            path: "Sources/MarvelService",
            plugins: [
                .plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator")
            ]
        ),
        .testTarget(
            name: MarvelService.test,
            dependencies: [
                .byName(name: MarvelService.target)
            ], 
            path: "Tests/MarvelService"
        ),
    ]
)

// MARK: - Constants

enum MarvelService {
    static let package = "marvel-service"
    static let target = "MarvelService"
    static let test = "\(MarvelService.target)Tests"
}
