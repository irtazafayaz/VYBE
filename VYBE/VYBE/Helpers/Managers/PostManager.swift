//
//  PostManager.swift
//  VYBE
//
//  Created by Hamza Hashmi on 17/07/2024.
//

import Foundation

class PostManager {
    
    static let shared = PostManager()
    
    @Published var posts: [Post] = []
    
    private init() {
        self.fetchPosts()
    }
    
    func fetchPosts() {
        posts = Array(repeating: Post(user: UserProfile(fullName: "Mande Portman"), description: "Unleash your inner chill with our Limber Up Tapered Leg Joggers. Featuring a relaxed fit and cool More..."), count: 5)
    }
}
