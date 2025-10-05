# ``MarvelService``

A library that allows the developer to interact with the **Marvel Comics API** backend service.

## Overview

The **MarvelService** library is a package that allows the developer to interact with all the available endpoints of the [Marvel Comics online service](https://developer.marvel.com).

## Installation

This library can be integrated into your library, tool, and/or app as an added dependency into any `Package.swift` file or Xcode project with the [Swift Package Manager](https://developer.apple.com/documentation/xcode/swift-packages).

Here's an example of how to add this library as a dependency into a `Package.swift` file:

```swift
let package = Package(
    // name, platforms, products, etc.
    dependencies: [
        .package(url: "https://github.com/rock-n-code/marvel-service", from: "1.0.0"),
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

In [Xcode](https://developer.apple.com/xcode/), on the other hand, it is required to use the Xcode inerface to add dependencies into a project or workspace.

> important: Swift 5.10 or higher is required in order to build this library.

## Usage

After adding the `MarvelService` library as a dependency in the library, tool, and/or application, as explained in the previous sec tion, then it is required to import the library.

```swift
import MarvelService
```

Then a ``Client`` must to be initialized. Although this type is highly configurable, and browsing through its documentation is highly recomendable; it requires three parameters to set the client correctly:

1. *a host URL to which the client connects to*;
2. *a transport in charge of performing the HTTP operations*;
3. *an authorization middleware configured with either an `api key` or a `private+public` keys*. 

```swift
let marvelClient = Client(
    serverURL: try Servers.Server1.url(),
    transport: URLSessionTransport(),
    middlewares: [
        AuthMiddleware(
            privateKey: "SomePrivateKey",
            publicKey: "SomePublicKey"
        )
    ]
)
```

> Important: It is mandatory to signup to the [Developer portal of Marvel Comics](https://developer.marvel.com/account) in order to obtain an *API Key* to use this library, as every request to this service [requires to be signed](https://developer.marvel.com/documentation/authorization).

Finally a client is ready to use! This client is now able to request any information regarding to any published Marvel *characters, comics, creators, events, series and stories* to the **Marvel Comics API** service, and handle its responses as follows:

```swift
do {
    let response = try await marvelClient.getCharacters(
        query: .init(name: "wolverine"),
    )

    switch response {
    case let .ok(ok):
        switch ok.body {
        case let .json(charactersContainer):
            // Do something with the `charactersContainer` object.
        }
    case let .unauthorized(standardError):
        // Do something with the `standardError` object.
    case .forbidden(_):
        // Do something here, like throwing an error.
    case let .notFound(standardError):
        // Do something with the `standardError` object.
    case let .methodNotAllowed(_):
        // Do something here, like throwing an error.
    case let .conflict(standardError):
        // Do something with the `standardError` object.
    case let .tooManyRequests(_):
        // Do something here, like throwing an error.
    case let .undocumented(statusCode, payload):
        // Do something with the `statusCode` and `payload` received from undeclared response, if required.
    }
} catch {
    // Do something with any catched error.
}
```

> Tip: It is highly recommended to go through the available documentation at the [Marvel Comics online service](https://developer.marvel.com)

> Warning: Please do create an issue in case of encountering problems interacting with any of the endpoints.

## Tasks

This library offers a set of ready-to-use tasks that simplify the interaction with the library, which the developer can use from any `Terminal` application. 

> Tip: To show the available list of tasks, plus display some explanations about each and every one of them; please enter the following command:

```bash
$ make
```

## Topics

### Client

- ``Client``

### Configuration

- ``Servers/Server1``
- ``AuthMiddleware``

### Core Entity Containers

- ``Components/Schemas/CharacterDataContainer``
- ``Components/Schemas/ComicDataContainer``
- ``Components/Schemas/CreatorDataContainer``
- ``Components/Schemas/EventDataContainer``
- ``Components/Schemas/SeriesDataContainer``
- ``Components/Schemas/StoryDataContainer``

### Core Entity Wrappers

- ``Components/Schemas/CharacterDataWrapper``
- ``Components/Schemas/ComicDataWrapper``
- ``Components/Schemas/CreatorDataWrapper``
- ``Components/Schemas/EventDataWrapper``
- ``Components/Schemas/SeriesDataWrapper``
- ``Components/Schemas/StoryDataWrapper``

### Core Entity List

- ``Components/Schemas/CharacterList``
- ``Components/Schemas/ComicList``
- ``Components/Schemas/CreatorList``
- ``Components/Schemas/EventList``
- ``Components/Schemas/SeriesList``
- ``Components/Schemas/StoryList``

### Core Entity Summaries

- ``Components/Schemas/CharacterSummary``
- ``Components/Schemas/ComicSummary``
- ``Components/Schemas/CreatorSummary``
- ``Components/Schemas/EventSummary``
- ``Components/Schemas/SeriesSummary``
- ``Components/Schemas/StorySummary``

### Core Entities

- ``Components/Schemas/Character``
- ``Components/Schemas/Comic``
- ``Components/Schemas/Creator``
- ``Components/Schemas/Event``
- ``Components/Schemas/Series``
- ``Components/Schemas/Story``

### Common Types

- ``Components/Schemas/ComicDate``
- ``Components/Schemas/ComicPrice``
- ``Components/Schemas/Image``
- ``Components/Schemas/TextObject``
- ``Components/Schemas/Url``

### Error Types

- ``Components/Schemas/StandardError``

### Namespaces

- ``Components``
- ``Operations``
- ``Servers``

### Protocols

- ``APIProtocol``