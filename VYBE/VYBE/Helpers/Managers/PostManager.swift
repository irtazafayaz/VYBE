//
//  PostManager.swift
//  VYBE
//
//  Created by Irtaza Fiaz on 17/07/2024.
//

import Foundation

class PostManager {
    
    static let shared = PostManager()
    
    @Published var posts: [Post] = []
    
    private init() {
        self.fetchPosts()
    }
    
    func fetchPosts() {
        for user in UserManager.shared.users {
            let post = Post(user: user, description: "Unleash your inner chill with our Limber Up Tapered Leg Joggers. Featuring a relaxed fit and cool More...")
            self.posts.append(post)
        }
    }
}
