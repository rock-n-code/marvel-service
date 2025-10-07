[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Frock-n-code%2Fmarvel-service%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/rock-n-code/marvel-service)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Frock-n-code%2Fmarvel-service%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/rock-n-code/marvel-service)

# Marvel Service

A library written entirely with [Swift](https://www.swift.org) that allow the developer to interact with the [Marvel Comics API](https://developer.marvel.com) backend service.

## Installation

To use this library, then add it as a dependency in the `Package.swift` file of your project:

```swift
let package = Package(
    // name, platforms, products, etc.
    dependencies: [
        .package(url: "https://github.com/rock-n-code/marvel-service", from: "1.1.0"),
        // other dependencies
    ],
    targets: [
        .target(
            name: "SomeTarget", 
            dependencies: [
                .product(name: "MarvelService", package: "marvel-service"),
            ]
        )
        // other targets
    ]
)
```

It is also possible to use this library with your app in Xcode, then add it as a dependency in your Xcode project.

> important: Swift 5.10 or higher is required in order to compile this library.

## Documentation

Please refer to the [online documentation](https://rock-n-code.github.io/marvel-service/documentation/marvelservice/) for further informations about this library.
