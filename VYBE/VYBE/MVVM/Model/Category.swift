//
//  Category.swift
//  VYBE
//
//  Created by Hamza Hashmi on 17/07/2024.
//

import Foundation

struct Category: Identifiable {
    
    let id = UUID().uuidString
    
    let image: ImageResource
    
    let name: String
    
    let posts: [Post]
}
