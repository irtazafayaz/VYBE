//
//  PostManager.swift
//  VYBE
//
//  Created by Irtaza Fiaz on 17/07/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage

class PostManager: ObservableObject {
    let postsRef = Firestore.firestore().collection("posts")
    static let shared = PostManager()
    private let storageRef = Storage.storage().reference()
    
    @Published var posts: [Post] = []
    @Published var allPosts: [FirebasePost] = []
    @Published var isLoading = false
    
    private var listenerRegistration: ListenerRegistration?
    
    private init() {
        self.fetchPosts()
        self.listenForPosts()
    }
    
    deinit {
        listenerRegistration?.remove()
    }
    
    func listenForPosts() {
        self.isLoading = true
        listenerRegistration = postsRef.addSnapshotListener { [weak self] querySnapshot, error in
            guard let self = self else { return }
            if let error = error {
                print("Error listening for posts: \(error.localizedDescription)")
                self.isLoading = false
                return
            }
            guard let documents = querySnapshot?.documents else {
                print("No documents found")
                self.isLoading = false
                return
            }
            self.allPosts = documents.compactMap { document in
                try? document.data(as: FirebasePost.self)
            }
            self.isLoading = false
        }
    }
    
    func addPost(post: FirebasePost) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            do {
                let _ = try postsRef.addDocument(from: post) { error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume()
                    }
                }
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
    
    func fetchPosts() {
        for user in UserManager.shared.users {
            let post = Post(user: user, description: "Unleash your inner chill with our Limber Up Tapered Leg Joggers. Featuring a relaxed fit and cool More...")
            self.posts.append(post)
        }
    }
    
    private func uploadImage(_ image: UIImage, path: String = "", completion: @escaping (Result<URL, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "ImageConversion", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert image to data"])))
            return
        }
        
        let imageID = UUID().uuidString
        let imageRef = storageRef.child("images\(path)/\(imageID).jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        imageRef.putData(imageData, metadata: metadata) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            imageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let downloadURL = url else {
                    completion(.failure(NSError(domain: "DownloadURL", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to get download URL"])))
                    return
                }
                
                completion(.success(downloadURL))
            }
        }
    }
    
    func uploadImage(_ image: UIImage, path: String) async throws -> URL {
        return try await withCheckedThrowingContinuation { continuation in
            PostManager.shared.uploadImage(image, path: path) { result in
                switch result {
                case .success(let url):
                    continuation.resume(returning: url)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
}
