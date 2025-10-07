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

extension Tag {
    
    // MARK: Constants
    
    /// A flag that indicates tests for a type extension.
    @Tag static var `extension`: Self
    
    /// A flag that indicates tests for a middleware type.
    @Tag static var middleware: Self
    
    /// A flag that indicates tests for a use case type.
    @Tag static var useCase: Self
}
