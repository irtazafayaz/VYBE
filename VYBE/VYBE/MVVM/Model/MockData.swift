//
//  MockData.swift
//  VYBE
//
//  Created by Irtaza Fiaz on 02/08/2024.
//

import Foundation
import Firebase
import FirebaseFirestore

// MARK: - User Profiles
let mockUserProfiles: [UserProfile] = [
    UserProfile(
        id: "user1",
        userName: "john_doe",
        address: "123 Main St, Springfield, USA",
        bio: "Passionate about running and coffee.",
        fullName: "John Doe",
        phone: "+1 555-555-5555",
        email: "john.doe@example.com",
        dob: "1985-07-15",
        cityAndCountry: "Springfield, USA",
        profileImageUrl: "https://img.freepik.com/premium-photo/egyptian-man-with-beard-glasses-smiles-camera_876101-19.jpg?w=1060"
    ),
    UserProfile(
        id: "user2",
        userName: "jane_doe",
        address: "456 Elm St, Springfield, USA",
        bio: "Loves afternoon coffee and reading.",
        fullName: "Jane Doe",
        phone: "+1 555-555-5556",
        email: "jane.doe@example.com",
        dob: "1990-03-22",
        cityAndCountry: "Springfield, USA",
        profileImageUrl: "https://img.freepik.com/premium-photo/egyptian-boy-with-curly-hair-smiles_876101-13.jpg?w=1060"
    ),
    UserProfile(
        id: "user3",
        userName: "alex_smith",
        address: "789 Oak St, Springfield, USA",
        bio: "Morning jogger and tech enthusiast.",
        fullName: "Alex Smith",
        phone: "+1 555-555-5557",
        email: "alex.smith@example.com",
        dob: "1988-11-09",
        cityAndCountry: "Springfield, USA",
        profileImageUrl: "https://img.freepik.com/premium-photo/egyptian-woman-smiles-camera_876101-22.jpg?w=1060"
    )
]

// MARK: - Posts
let mockPosts: [FirebasePost] = [
    FirebasePost(
        id: "1",
        userRef: Firestore.firestore().document("users/user1"),
        user: mockUserProfiles[0],
        description: "Enjoying a morning jog with my new joggers and a cup of coffee!",
        postedTime: Date(timeIntervalSinceNow: -3600),
        updatedTime: Date(timeIntervalSinceNow: -1800),
        tags: ["Joggers", "Coffee"],
        images: [
            ImageLink(url: "https://img.freepik.com/premium-photo/brazilian-woman-wearing-vacation-outfit_52683-130994.jpg?ga=GA1.1.943601403.1690795971", affiliateLink: nil),
            ImageLink(url: "https://img.freepik.com/premium-photo/waterfall-canyon-with-green-tree-foreground_899894-18811.jpg?w=2000", affiliateLink: "https://example.com/affiliate-link-1")
        ]
    ),
    FirebasePost(
        id: "2",
        userRef: Firestore.firestore().document("users/user2"),
        user: mockUserProfiles[1],
        description: "Afternoon coffee break!",
        postedTime: Date(timeIntervalSinceNow: -7200),
        updatedTime: Date(timeIntervalSinceNow: -3600),
        tags: ["Coffee"],
        images: [
            ImageLink(url: "https://img.freepik.com/premium-photo/brazilian-woman-wearing-vacation-outfit_52683-130994.jpg?ga=GA1.1.943601403.1690795971", affiliateLink: "https://example.com/affiliate-link-2"),
            ImageLink(url: "https://img.freepik.com/premium-photo/waterfall-canyon-with-green-tree-foreground_899894-18811.jpg?w=2000", affiliateLink: nil)
        ]
    ),
    FirebasePost(
        id: "3",
        userRef: Firestore.firestore().document("users/user3"),
        user: mockUserProfiles[2],
        description: "Morning run in the park.",
        postedTime: Date(timeIntervalSinceNow: -10800),
        updatedTime: Date(timeIntervalSinceNow: -5400),
        tags: ["Joggers"],
        images: [
            ImageLink(url: "https://img.freepik.com/premium-photo/brazilian-woman-wearing-vacation-outfit_52683-130994.jpg?ga=GA1.1.943601403.1690795971", affiliateLink: nil),
            ImageLink(url: "https://img.freepik.com/premium-photo/waterfall-canyon-with-green-tree-foreground_899894-18811.jpg?w=2000", affiliateLink: "https://example.com/affiliate-link-3")
        ]
    )
]
