//===----------------------------------------------------------------------===
//
// This source file is part of the MarvelService open source project
//
// Copyright (c) -2025 Röck+Cöde VoF. and the MarvelService project authors
// Licensed under the EUPL 1.2 or later.
//
// See LICENSE for license information
// See CONTRIBUTORS for the list of MarvelService project authors
//
//===----------------------------------------------------------------------===

import struct Foundation.TimeInterval

extension TimeInterval {
    
    // MARK: Functions
    
    /// Converts a time interval to a string value.
    /// - Returns: A time interval as a string.
    var asString: String {
        .init(format: "%f", self)
    }
    
}
