//
//  File.swift
//  pirategram
//
//  Created by Eddie Wei on 1/10/23.
//

import Foundation
import FirebaseAuth

enum AuthError: Error {
    case failSignin
    case failCreateUser
}

class AuthManager {
    var auth = Auth.auth()
    
    /// Create a user with `email` and `password`.
    /// Returns the `uid` of the user if successful.
    func createUser(email: String, password: String) async throws -> String? {
        return try await withCheckedThrowingContinuation { continuation in
            auth.createUser(withEmail: email, password: password) { authResult, error in
                if error != nil { continuation.resume(throwing: error!); return }
                if authResult == nil { continuation.resume(throwing: AuthError.failCreateUser); return }
                continuation.resume(returning: authResult!.user.uid)
            }
        }
    }
    
    /// Authenticates user with `email` and `password`.
    /// Returns the `uid` of the user if successful.
    func authUser(email: String, password: String) async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            auth.signIn(withEmail: email, password: password) { authResult, error in
                if error != nil { continuation.resume(throwing: error!); return }
                if authResult == nil { continuation.resume(throwing: AuthError.failSignin); return }
                continuation.resume(returning: authResult!.user.uid)
            }
        }
    }
}
