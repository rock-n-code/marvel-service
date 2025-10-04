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
import struct MarvelService.AuthMiddleware

@Suite("Auth Middleware", .tags(.middleware))
struct AuthMiddlewareTest {
    
    // MARK: Functions
    
#if swift(>=6.2)
    @Test(arguments: Input.pathRequests)
    func `intercept`(path: String?) async throws {
        try await assertIntercept(path: path)
    }
#else
    @Test("intercept", arguments: Input.pathRequests)
    func intercept(path: String?) async throws {
        try await assertIntercept(path: path)
    }
#endif
    
}

// MARK: - Assertions

private extension AuthMiddlewareTest {
    
    // MARK: Functions
    
    /// Asserts the interception of a request to add authentication parameters in it.
    /// - Parameter path: A URI path for a request.
    /// - Throws: An error in case
    func assertIntercept(path: String?) async throws {
        // GIVEN
        let baseURL: URL = .baseURL
        let request: HTTPRequest = .init(path: path)
        
        let middleware: AuthMiddleware = .init(
            privateKey: .Key.private,
            publicKey: .Key.public
        )
        
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
                    
                    #expect(queryItems.count >= 3)
                    #expect(queryItems.contains(where: { $0.name == "ts" }))
                    #expect(queryItems.contains(where: { $0.name == "apikey" }))
                    #expect(queryItems.contains(where: { $0.name == "hash" }))
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
