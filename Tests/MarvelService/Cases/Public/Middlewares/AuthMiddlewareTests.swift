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

import Testing

import struct Foundation.URL
import struct Foundation.URLComponents
import struct HTTPTypes.HTTPRequest
import struct HTTPTypes.HTTPResponse

@testable import MarvelService

@Suite("Auth Middleware", .tags(.middleware))
struct AuthMiddlewareTest {
    
    // MARK: Functions
    
#if swift(>=6.2)
    @Test(arguments: Input.pathRequests)
    func `intercept with API key`(
        path: String?
    ) async throws {
        try await assertIntercept(
            path: path,
            with: .Key.api
        )
    }
    
    @Test(arguments: Input.pathRequests)
    func `intercept with private and public keys`(
        path: String?
    ) async throws {
        try await assertIntercept(
            path: path,
            with: .Key.public,
            and: .Key.private
        )
    }
#else
    @Test("intercept with API key", arguments: Input.pathRequests)
    func interceptWithAPIKey(
        path: String?
    ) async throws {
        try await assertIntercept(
            path: path,
            with: .Key.api
        )
    }
    
    @Test("intercept with private and public keys", arguments: Input.pathRequests)
    func interceptWithKeys(
        path: String?
    ) async throws {
        try await assertIntercept(
            path: path,
            with: .Key.public,
            and: .Key.private
        )
    }
#endif
    
}

// MARK: - Assertions

private extension AuthMiddlewareTest {
    
    // MARK: Functions
    
    /// Asserts the interception of a request to add authentication parameters in it.
    /// - Parameter path: A URI path for a request.
    /// - Parameter apiKey: A Marvel (public) API key.
    /// - Parameter privateKey: <#publicKey description#>
    /// - Throws: An error in case
    func assertIntercept(
        path: String?,
        with apiKey: String,
        and privateKey: String? = nil
    ) async throws {
        // GIVEN
        let baseURL: URL = .baseURL
        let request: HTTPRequest = .init(path: path)
        
        let middleware: AuthMiddleware = if let privateKey {
            .init(
                privateKey: privateKey,
                publicKey: apiKey
            )
        } else {
            .init(apiKey: apiKey)
        }
        
        // WHEN
        _ = try await confirmation { confirmation in
            try await middleware.intercept(
                request,
                body: nil,
                baseURL: baseURL,
                operationID: .operationId
            ) { request, _, _ in
                // THEN
                if path != nil {
                    let pathRequest = try #require(request.path)
                    let urlComponents = try #require(URLComponents(string: pathRequest))
                    let queryItems = try #require(urlComponents.queryItems)
                    
                    #expect(queryItems.contains(where: { $0.name == .Parameter.apiKey }))

                    if privateKey == nil {
                        #expect(queryItems.count >= 1)
                    } else {
                        #expect(queryItems.contains(where: { $0.name == .Parameter.hash }))
                        #expect(queryItems.contains(where: { $0.name == .Parameter.timestamp }))
                        #expect(queryItems.count >= 3)
                    }
                } else {
                    #expect(request.path == nil)
                }

                confirmation()
                
                return (.init(status: .ok) , nil)
            }
        }
    }
    
}

// MARK: - Helpers

private extension HTTPRequest {
    
    // MARK: Initializers
    
    /// Initializes a HTTP request with a method and a path.
    /// - Parameters:
    ///   - method: The request method.
    ///   - path: The value of the “:path” pseudo header field.
    init(
        method: HTTPRequest.Method = .get,
        path: String?
    ) {
        self.init(
            method: method,
            scheme: nil,
            authority: nil,
            path: path
        )
    }

}

// MARK: - Constants

private extension Input {
    /// A list of URI path to a resource for a request.
    static let pathRequests: [String?] = [
        nil,
        "/path/to/resource",
        "/path/to/resource?boolean",
        "/path/to/resource?query=value",
        "/path/to/resource?query=value&anotherQuery=anotherValue"
    ]
}

private extension String {
    /// An operation ID sample.
    static let operationId = "SomeOperationId"
}

private extension URL {
    /// A base URL sample.
    static let baseURL = URL(string: "https://sample.domain.com")!
}
