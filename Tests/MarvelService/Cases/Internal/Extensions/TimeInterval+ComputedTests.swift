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

import Testing

import struct Foundation.TimeInterval

@testable import MarvelService

@Suite("Time Interval computed properties", .tags(.extension))
struct TimeIntervalComputedTests {
    
    // MARK: Properties tests
    
#if swift(>=6.2)
    @Test(arguments: zip(
        Input.timestamps,
        Output.timestampAsString
    ))
    func `asString`(
        timestamp: TimeInterval,
        expects string: String
    ) {
        assertAsString(
            timestamp: timestamp,
            expects: string
        )
    }
#else
    @Test("asString", arguments: zip(
        Input.timestamps,
        Output.timestampAsString
    ))
    func asString(
        timestamp: TimeInterval,
        expects string: String
    ) {
        assertAsString(
            timestamp: timestamp,
            expects: string
        )
    }
#endif
    
}

// MARK: - Assertions

private extension TimeIntervalComputedTests {
    
    // MARK: Functions
    
    /// Asserts the timestamp to string conversion.
    /// - Parameters:
    ///   - timestamp: A timestamp to convert.
    ///   - string: An expected timestamp converted to string.
    func assertAsString(
        timestamp: TimeInterval,
        expects string: String
    ) {
        // GIVEN
        // WHEN
        let result = timestamp.asString
        
        // THEN
        #expect(result == string)
    }

}

// MARK: - Constants

private extension Output {
    /// A list of outcomes that are expected from converting timestamps to string.
    static let timestampAsString: [String] = [
        "0.000000",
        "1000.000000",
        "1000000.000000",
        "1000000000.000000"
    ]
}
