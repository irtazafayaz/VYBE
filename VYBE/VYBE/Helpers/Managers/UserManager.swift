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
    
    private let usersRef = Firestore.firestore().collection("users")
    
    @Published var users: [UserProfile] = []
    @Published var userProfile: UserProfile? = nil
    @Published var isLoading = false
    
    private init() {
        fetchUsers()
        fetchProfile()
    }
    
    func fetchProfile() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        isLoading = true
        
        Task {
            do {
                let user = try await usersRef.document(uid).getDocument(as: UserProfile.self)
                DispatchQueue.main.async {
                    self.userProfile = user
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.isLoading = false
                    print(#function, error)
                }
            }
        }
    }
    
    func createUser(userProfile: UserProfile) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        try await setUserProfile(uid: uid, userProfile: userProfile)
    }
    
    func updateUser(userProfile: UserProfile) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        try await setUserProfile(uid: uid, userProfile: userProfile)
        DispatchQueue.main.async {
            self.userProfile = userProfile
        }
    }
    
    private func setUserProfile(uid: String, userProfile: UserProfile) async throws {
        do {
            try usersRef.document(uid).setData(from: userProfile)
        } catch {
            throw error
        }
    }
    
    func fetchUsers() {
        let fullnames = [
            "Arthur Morgan", "Billie Eilish", "Carl Johnson", "Faheem Commando",
            "Imran Khan", "Johar Khan", "Momina Mustehsan", "Leon Kennedy",
            "Lara Croft", "Queen Elizabeth", "Rehana Singer"
        ]
        
        users = fullnames.map { UserProfile(id: UUID().uuidString, fullName: $0) }
    }
}
