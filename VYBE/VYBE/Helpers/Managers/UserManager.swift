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
    
    @Published var users: [UserProfile] = []
    
    private init() {
        self.fetchUsers()
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
    
    func fetchUsers() {
        self.users = Array(repeating: .init(fullName: "Arthur Morgan"), count: 10)
    }
}
