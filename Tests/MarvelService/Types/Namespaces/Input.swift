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

import struct Foundation.Date
import struct Foundation.TimeInterval

/// A namespace assigned for input arguments on test cases.
enum Input {
    
    // MARK: Constants

    /// A list of timestamps samples.
    static let timestamps: [TimeInterval] = [
        Date(timeIntervalSince1970: 0).timeIntervalSince1970,
        Date(timeIntervalSince1970: 1_000).timeIntervalSince1970,
        Date(timeIntervalSince1970: 1_000_000).timeIntervalSince1970,
        Date(timeIntervalSince1970: 1_000_000_000).timeIntervalSince1970,
    ]
}
