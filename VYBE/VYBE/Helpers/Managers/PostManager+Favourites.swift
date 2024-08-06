//
//  PostManager+Favourites.swift
//  VYBE
//
//  Created by Irtaza Fiaz on 03/08/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage

extension PostManager {
    func markPostAsFavourites(post: FirebasePost) async throws {
        guard let postId = post.id else {
            throw NSError(domain: "Invalid Post", code: -1)
        }
        guard let userId = UserManager.shared.userProfile?.id else {
            throw NSError(domain: "Not Authenticated", code: -1)
        }
        
        let postRef = postsRef.document(postId)
        let userFavRef = favouritesRef.document(userId)
        
        do {
            let document = try await userFavRef.getDocument()
            var favouritePosts = FavouritePosts(posts: [])
            
            if document.exists {
                favouritePosts = try! document.data(as: FavouritePosts.self)
            }
            
            if !favouritePosts.posts.contains(postRef) {
                favouritePosts.posts.append(postRef)
            }
            
            // Save to Firestore, which creates the document if it doesn't exist
            try userFavRef.setData(from: favouritePosts)
            
        } catch {
            throw error
        }
    }
    
    func fetchFavouritePosts() async throws {
        guard let userId = UserManager.shared.userProfile?.id else {
            throw NSError(domain: "Not Authenticated", code: -1)
        }
        
        let userFavRef = favouritesRef.document(userId)
        
        do {
            let document = try await userFavRef.getDocument()
            guard document.exists else { return }
            
            let favouritePostsDocument = try? document.data(as: FavouritePosts.self)
            if let posts = favouritePostsDocument?.posts {
                for postRef in posts {
                    let postDocument = try await postRef.getDocument()
                    if let post = try? postDocument.data(as: FirebasePost.self) {
                        DispatchQueue.main.async { [weak self] in
                            self?.favouritePosts.append(post)
                        }
                    }
                }
            }
        } catch {
            throw error
        }
    }
}

