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
