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
    
    func signUp(userName: String, fullName: String, phone: String, email: String, dob: String, cityAndCountry: String, password: String, confirmPassword: String) async throws {
        
        guard !userName.isEmpty,
              !fullName.isEmpty,
              !phone.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              !confirmPassword.isEmpty,
              !dob.isEmpty,
              !cityAndCountry.isEmpty
        else {
            throw AuthError.emptyFields
        }
        
        let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        
        let userProfile = UserProfile(
            id: authResult.user.uid,
            userName: userName,
            fullName: fullName,
            phone: phone,
            email: email,
            dob: dob,
            cityAndCountry: cityAndCountry
        )
        
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
