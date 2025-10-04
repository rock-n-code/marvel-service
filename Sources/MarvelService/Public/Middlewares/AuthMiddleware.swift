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
    
    /// A use case that generates a MD5 hash value to use as an authentication parameter.
    private let hash: GenerateHashUseCase
    
    /// A Marvel API public key.
    private let publicKey: String
    
    // MARK: Initializers

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
        self.hash = .init(
            privateKey: privateKey,
            publicKey: publicKey
        )
        self.publicKey = publicKey
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
        guard
            let uriPath = request.path,
            var urlComponents = URLComponents(string: uriPath)
        else {
            return try await next(request, body, baseURL)
        }

        let queryItems = urlComponents.queryItems ?? []
        let timestamp = Date().timeIntervalSince1970

        urlComponents.queryItems = queryItems + [
            .init(name: "ts", value: timestamp.asString),
            .init(name: "apikey", value: publicKey),
            .init(name: "hash", value: hash(timestamp: timestamp))
        ]
        
        let newPath = if let urlQuery = urlComponents.query {
            urlComponents.path + "?" + urlQuery
        } else {
            urlComponents.path
        }

        let newRequest = HTTPRequest(
            method: request.method,
            scheme: request.scheme,
            authority: request.authority,
            path: newPath,
            headerFields: request.headerFields
        )

        return try await next(newRequest, body, baseURL)
    }
    
}
