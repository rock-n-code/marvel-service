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

import struct Foundation.TimeInterval

@testable import struct MarvelService.GenerateHashUseCase

@Suite("Generate Hash Use Case", .tags(.useCase))
struct GenerateHashUseCaseTests {
    
    // MARK: Functions
    
#if swift(>=6.2)
    @Test(arguments: zip(
        Input.timestamps,
        Output.generatedHashes
    ))
    func `hash`(
        timestamp: TimeInterval,
        expects hash: String
    ) async throws {
        assertHash(
            timestamp: timestamp,
            expects: hash
        )
    }
#else
    @Test("hash", arguments: zip(
        Input.timestamps,
        Output.generatedHashes
    ))
    func hash(
        timestamp: TimeInterval,
        expects hash: String
    ) async throws {
        assertHash(
            timestamp: timestamp,
            expects: hash
        )
    }
#endif
    
}

// MARK: - Assertions

private extension GenerateHashUseCaseTests {
   
    // MARK: Functions
    
    /// Asserts the MD5 hash generated from the use case.
    /// - Parameters:
    ///   - timestamp: A timestamp to use in the hash generation.
    ///   - hash: An expected MD5 hash string as a result of the use case.
    func assertHash(
        timestamp: TimeInterval,
        expects hash: String
    ) {
        // GIVEN
        let useCase: GenerateHashUseCase = .init(
            privateKey: .Key.private,
            publicKey: .Key.public
        )

        // WHEN
        let result = useCase(timestamp: timestamp)

        // THEN
        #expect(result == hash)
    }
    
}

// MARK: - Constants

private extension Output {
    /// A list of outcomes that are expected from the hash generation.
    static let generatedHashes: [String] = [
        "ef9ca6f930e56fb4f8a109a9003580fe",
        "b500748e9f0aabc67ffc640ae9b87695",
        "b537f18579112902b7ce046dddad558a",
        "00fec88a254d42e3a439d49e14cd60d1"
    ]
}
