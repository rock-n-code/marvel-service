//===----------------------------------------------------------------------===
//
// This source file is part of the MarvelService open source project
//
// Copyright (c) 2025 Röck+Cöde VoF. and the MarvelService project authors
// Licensed under the EUPL 1.2 or later.
//
// See LICENSE for license information
// See CONTRIBUTORS for the list of MarvelService project authors
//
//===----------------------------------------------------------------------===

import class OpenAPIRuntime.HTTPBody

import protocol OpenAPIRuntime.ClientMiddleware

import struct Foundation.Date
import struct Foundation.TimeInterval
import struct Foundation.URL
import struct Foundation.URLComponents
import struct HTTPTypes.HTTPRequest
import struct HTTPTypes.HTTPResponse

/// A middleware that attaches the necessary authentication parameters to the path of the request.
public struct AuthMiddleware {
    
    // MARK: Properties
    
    /// A Marvel API key.
    private let apiKey: String
    
    /// A use case that generates a MD5 hash value to use as an authentication parameter.
    private let hash: GenerateHashUseCase?

    // MARK: Initializers
    
    /// Initializes this middleware with an api key.
    ///
    /// The middleware attaches the required `apikey` parameter to the URI path of the intercepted request.
    /// This initializer should be used for client-side applications, as indicated in the [Marvel API documentation](https://developer.marvel.com/documentation/authorization)
    ///
    /// - Parameter apiKey: A Marvel API key.
    public init(apiKey: String) {
        self.apiKey = apiKey
        self.hash = nil
    }

    /// Initializes this middleware with private and public keys.
    ///
    /// The middleware attaches the required `apikey`, `ts`, and `hash` parameters to the URI path of the intercepted request.
    /// This initializer should be used for server-side applications, as indicated in the [Marvel API documentation](https://developer.marvel.com/documentation/authorization)
    ///
    /// - Parameters:
    ///   - privateKey: A Marvel API private key.
    ///   - publicKey: A Marvel API public key.
    public init(
        privateKey: String,
        publicKey: String
    ) {
        self.apiKey = publicKey
        self.hash = .init(
            privateKey: privateKey,
            publicKey: publicKey
        )
    }
    
}

// MARK: - ClientMiddleware

extension AuthMiddleware: ClientMiddleware {
    
    // MARK: Functions
    
    public func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: @Sendable (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        guard let path = request.path else {
            return try await next(request, body, baseURL)
        }

        return try await next(
            .init(
                method: request.method,
                scheme: request.scheme,
                authority: request.authority,
                path: authenticatedPath(path),
                headerFields: request.headerFields
            ),
            body,
            baseURL
        )
    }
    
}

// MARK: - Helpers

private extension AuthMiddleware {
    
    // MARK: Functions
    
    /// Adds the necessary authentication parameters to a given request path.
    /// - Parameter path: A request path to authenticate.
    /// - Returns: A request path with the necessary authentication parameters added.
    func authenticatedPath(_ path: String) -> String {
        guard var urlComponents = URLComponents(string: path) else {
            return path
        }
        
        var queryItems = urlComponents.queryItems ?? []
        
        queryItems.append(.init(
            name: .Parameter.apiKey,
            value: apiKey
        ))
        
        if let hash {
            let timestamp = Date().timeIntervalSince1970
            
            queryItems.append(contentsOf: [
                .init(
                    name: .Parameter.hash,
                    value: hash(timestamp: timestamp)
                ),
                .init(
                    name: .Parameter.timestamp,
                    value: timestamp.asString
                ),
            ])
        }
        
        urlComponents.queryItems = queryItems
        
        return if let urlQuery = urlComponents.query {
            urlComponents.path + "?" + urlQuery
        } else {
            urlComponents.path
        }
    }

}
