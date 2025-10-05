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

#if canImport(CriptoKit)
import CryptoKit
#elseif canImport(Crypto)
import Crypto
#else
import CommonCrypto
#endif

import struct Foundation.Data
import struct Foundation.TimeInterval

/// A use case that generates a MD5 hash value, which is required to authenticate any request.
struct GenerateHashUseCase {
    
    // MARK: Properties
    
    /// A private key.
    private let privateKey: String
    
    /// A public key.
    private let publicKey: String

    // MARK: Initializers
    
    /// Initializes this use case.
    /// - Parameters:
    ///   - privateKey: A private key.
    ///   - publicKey: A public key.
    init(
        privateKey: String,
        publicKey: String
    ) {
        self.privateKey = privateKey
        self.publicKey = publicKey
    }
    
    // MARK: Functions
    
    /// Generates a MD5 hash value out of a given public key, private key and a timestamp.
    /// - Parameter timestamp: A timestamp that changes on a request-by-request basis.
    /// - Returns: A MD5 hash generated out of a private key, an public key, and a timestamp.
    func callAsFunction(
        timestamp: TimeInterval
    ) -> String {
        let stringToHash = timestamp.asString + self.privateKey + self.publicKey
        let dataToHash = Data(stringToHash.utf8)

#if canImport(CriptoKit) || canImport(Crypto)
        return Insecure.MD5
            .hash(data: dataToHash)
            .map { String(format: .Format.hexadecimal, $0) }
            .joined()
#else
        return dataToHash
            .withUnsafeBytes {
                var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
                
                CC_MD5($0.baseAddress, CC_LONG(dataToHash.count), &hash)
                
                return hash
            }
            .map { String(format: .Format.hexadecimal, $0) }
            .joined()
#endif
    }
    
}

// MARK: - Constants

private extension String {
    /// A namespace assigned to string format representations.
    enum Format {
        /// A string format for MD5 hash hexadecimal bytes.
        static let hexadecimal = "%02x"
    }
}
