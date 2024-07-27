//
//  Post.swift
//  VYBE
//
//  Created by Irtaza Fiaz on 17/07/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Post: Identifiable {
    
    var id = UUID().uuidString
    
    let user: UserProfile
    
    let userImage: ImageResource = .sampleUser1
    
    let description: String
    
    let postedTime = Date()
    
    let updatedTime = Date()
    
    let tags: [String] = [
        "Joggers",
        "Coffee"
    ]
    
    let images = Constants.postImages
}

struct FirebasePost: Identifiable, Codable {
    @DocumentID var id: String?
    
    let user: UserProfile
    let description: String
    var postedTime = Date()
    var updatedTime = Date()
    var tags: [String] = [
        "Joggers",
        "Coffee"
    ]
    let images: [String]?
}
