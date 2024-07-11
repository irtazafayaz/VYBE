//
//  UserManager.swift
//  VYBE
//
//  Created by Hamza Hashmi on 12/07/2024.
//

import Foundation
import FirebaseFirestore

class UserManager {
    
    static let shared = UserManager()
    
    let usersRef = Firestore.firestore().collection("users")
    
    private init() {
        
    }
    
    func createUser(userProfile: UserProfile) async throws {
        return try await withUnsafeThrowingContinuation { continuation in
            do {
                try self.usersRef.document(userProfile.id).setData(from: userProfile) { error in
                    if let error {
                        continuation.resume(throwing: error)
                    }
                    else {
                        continuation.resume()
                    }
                }
            }
            catch {
                continuation.resume(throwing: error)
            }
        }
    }
}
