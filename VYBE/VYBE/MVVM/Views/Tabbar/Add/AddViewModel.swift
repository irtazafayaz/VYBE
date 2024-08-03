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
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage

class AddViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    
    @Published var showSuccess = false
    @Published var tags = ["Women","Trending","Wathces"]
    @Published var newTag = ""
    @Published var desc = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    @Published var selectedItems = [PhotosPickerItem]()
    @Published var selectedUiImages = [UIImage]()
    @Published var affiliateLinks: [Int: String] = [:]
    
    func addTag() {
        if !newTag.isEmpty {
            tags.append(newTag)
            newTag = ""
        }
    }
    
    func addNewPost() async {
        guard let user = UserManager.shared.userProfile else { return }
        let imageLinks = await collectImageLinks(for: "/posts/\(user.userName)")
        let userRef = Firestore.firestore().collection("users").document(user.id)
        let post = FirebasePost(userRef: userRef, user: user, description: desc, images: imageLinks)
        do {
            try await PostManager.shared.addPost(post: post)
            DispatchQueue.main.async {
                self.showSuccess = true
            }
        } catch {
            print("Error adding new post: \(error)")
        }
    }
    
    private func collectImageLinks(for path: String) async -> [ImageLink] {
        await withTaskGroup(of: ImageLink?.self) { group in
            for (index, image) in selectedUiImages.enumerated() {
                group.addTask {
                    do {
                        let url = try await PostManager.shared.uploadImage(image, path: "\(path)/\(UUID().uuidString)")
                        let affiliateLink = self.affiliateLinks[index]
                        return ImageLink(url: url.absoluteString, affiliateLink: affiliateLink)
                    } catch {
                        print("Failed to upload image: \(error)")
                        return nil
                    }
                }
            }
            
            var imageLinks: [ImageLink] = []
            for await imageLink in group {
                if let imageLink = imageLink {
                    imageLinks.append(imageLink)
                }
            }
            return imageLinks
        }
    }
}
