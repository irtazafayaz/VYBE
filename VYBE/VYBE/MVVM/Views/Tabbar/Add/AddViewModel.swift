//
//  AddViewModel.swift
//  VYBE
//
//  Created by Macbook 5 on 7/17/24.
//

import Foundation
import Combine
import PhotosUI
import SwiftUI

class AddViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    
    @Published var showSuccess = false
    @Published var tags = ["Women","Trending","Wathces"]
    @Published var newTag = ""
    @Published var desc = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eu nunc fermentum diam sed scelerisque id. Montes, massa facilisi pharetra nam."
    @Published var selectedItems = [PhotosPickerItem]()
    @Published var selectedUiImages = [UIImage]()
    
    func addTag() {
        if !newTag.isEmpty {
            tags.append(newTag)
            newTag = ""
        }
    }
    
    func addNewPost() async {
        guard let user = UserManager.shared.userProfile else { return }
        
        let imageUrls = await collectImageUrls(for: user.userName)
        
        let post = FirebasePost(user: user, description: desc, images: imageUrls)
        
        do {
            try await PostManager.shared.addPost(post: post)
            DispatchQueue.main.async {
                self.showSuccess = true
            }
        } catch {
            print("Error adding new post: \(error)")
        }
    }
    
    private func collectImageUrls(for path: String) async -> [String] {
        await withTaskGroup(of: URL?.self) { group in
            for image in selectedUiImages {
                group.addTask {
                    do {
                        return try await self.uploadImage(image, path: path)
                    } catch {
                        print("Failed to upload image: \(error)")
                        return nil
                    }
                }
            }
            
            var urls: [String] = []
            for await url in group {
                if let url = url {
                    urls.append(url.absoluteString)
                }
            }
            return urls
        }
    }
    
    private func uploadImage(_ image: UIImage, path: String) async throws -> URL {
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


