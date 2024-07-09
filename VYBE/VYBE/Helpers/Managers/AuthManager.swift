//
//  AuthManager.swift
//  VYBE
//
//  Created by Hamza Hashmi on 10/07/2024.
//

import Foundation
import FirebaseAuth

class AuthManager {
    
    static let shared = AuthManager()
    
    enum SignInState {
        case signedIn
        case signedOut
    }
    
    enum AuthError: Error {
        case emptyFields
    }
    
    func signUp(name: String, email: String, password: String) async throws {
        
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            throw AuthError.emptyFields
        }
        
        try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    func signIn(email: String, password: String) async throws {
        
        guard !email.isEmpty, !password.isEmpty else {
            throw AuthError.emptyFields
        }
        
        try await Auth.auth().signIn(withEmail: email, password: password)
    }

    func forgotPassword(email: String) async throws {
        
        guard !email.isEmpty else {
            throw AuthError.emptyFields
        }
        
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }

}
