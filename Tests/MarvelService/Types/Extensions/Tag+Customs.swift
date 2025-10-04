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

extension Tag {
    
    // MARK: Constants
    
    /// A flag that indicates tests for a type extension.
    @Tag static var `extension`: Self
    
    /// A flag that indicates tests for a middleware type.
    @Tag static var middleware: Self
    
    /// A flag that indicates tests for a use case type.
    @Tag static var useCase: Self
}
