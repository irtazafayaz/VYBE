//
//  Post.swift
//  VYBE
//
//  Created by Hamza Hashmi on 17/07/2024.
//

import Foundation

struct Post: Identifiable {
    
    var id = UUID().uuidString
    
    let user: UserProfile
    
    let userImage: ImageResource = .sampleProduct
    
    let description: String
    
    let postedTime = Date()
    
    let updatedTime = Date()
    
    let tags: [String] = [
        "Joggers",
        "Coffee"
    ]
    
    let images: [ImageResource] = [
        .samplePostImage2,
        .sampleProduct,
        .sampleVertical,
        .sampleCoverPhoto,
        .samplePost
    ]
}
