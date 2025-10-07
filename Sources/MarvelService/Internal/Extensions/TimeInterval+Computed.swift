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

import struct Foundation.TimeInterval

extension TimeInterval {
    
    // MARK: Functions
    
    /// Converts a time interval to a string value.
    /// - Returns: A time interval as a string.
    var asString: String {
        .init(format: "%f", self)
    }
    
}
