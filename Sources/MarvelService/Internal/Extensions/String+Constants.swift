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

extension String {
    /// A namespace assigned for parameter keys of URI paths.
    enum Parameter {
        /// A Marvel API key parameter.
        static let apiKey = "apikey"
        /// A MD5 hash parameter.
        static let hash = "hash"
        /// A timestamp parameter.
        static let timestamp = "ts"
    }
}
