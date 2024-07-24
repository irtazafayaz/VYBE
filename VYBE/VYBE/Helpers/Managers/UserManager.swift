//
//  UserManager.swift
//  VYBE
//
//  Created by Irtaza Fiaz on 12/07/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class UserManager {
    
    static let shared = UserManager()
    
    let usersRef = Firestore.firestore().collection("users")
    
    @Published var users: [UserProfile] = []
    
    @Published var userProfile: UserProfile? = nil
    
    @Published var isLoading = false
    
    private init() {
        self.fetchUsers()
        self.fetchProfile()
    }
    
    func fetchProfile() {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        Task {
            self.isLoading = true
            do {
                let user = try await self.usersRef.document(uid).getDocument(as: UserProfile.self)
                
                self.userProfile = user
            }
            catch {
                print(#function, error)
            }
            self.isLoading = false
        }
    }
    
    func createUser(userProfile: UserProfile) async throws {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        return try await withUnsafeThrowingContinuation { continuation in
            do {
                try self.usersRef.document(uid).setData(from: userProfile) { error in
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
        
        let fullnames = [
            "Arthur Morgan",
            "Billie Eilish",
            "Carl Johnson",
            "Faheem Commando",
            "Imran Khan",
            "Johar Khan",
            "Momina Mustehsan",
            "Leon Kennedy",
            "Lara Croft",
            "Queen Elizabeth",
            "Rehana Singer",
        ]
        
        for fullname in fullnames {
            let user = UserProfile(id: UUID().uuidString, fullName: fullname)
            self.users.append(user)
        }
    }
}
