//
//  AuthManager.swift
//  VYBE
//
//  Created by Hamza Hashmi on 10/07/2024.
//

import Foundation
import FirebaseAuth

enum AuthError: Error {
    case emptyFields
}

class AuthManager {
    
    static let shared = AuthManager()
    
    enum SignInState {
        case signedIn
        case signedOut
    }
    
    func signUp(userProfile: UserProfile, password: String, confirmPassword: String) async throws {
        
        guard !userProfile.userName.isEmpty,
              !userProfile.fullName.isEmpty,
              !userProfile.phone.isEmpty,
              !userProfile.email.isEmpty,
              !password.isEmpty,
              !confirmPassword.isEmpty,
              !userProfile.dob.isEmpty,
              !userProfile.cityAndCountry.isEmpty
        else {
            throw AuthError.emptyFields
        }
        
        try await Auth.auth().createUser(withEmail: userProfile.email, password: password)
        
        try await UserManager.shared.createUser(userProfile: userProfile)
    }
    
    func signIn(email: String, password: String) async throws {
        
        guard !email.isEmpty, !password.isEmpty else {
            throw AuthError.emptyFields
        }
        
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func signInAnonymous() async throws {
        try await Auth.auth().signInAnonymously()
    }

    func forgotPassword(email: String) async throws {
        
        guard !email.isEmpty else {
            throw AuthError.emptyFields
        }
        
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print(#function, error)
        }
    }
}
