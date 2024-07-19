//
//  CoverAndProfilePhoto.swift
//  VYBE
//
//  Created by Hamza Hashmi on 19/07/2024.
//

import Foundation
import SwiftUI

struct ProfileTopHeader: View {
    
    let user: UserProfile
    
    let followersCount: Int
    
    let favoritesCount: Int
    
    var body: some View {
        
        VStack(spacing: 0) {
            ZStack {
                CoverPhoto()
                    .frame(maxHeight: .infinity, alignment: .top)
                
                // Overlay Cover Photo
                ProfilePhoto()
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
            .frame(height: 218)
            
            FollowersFavorites()
            
            UserName()
                .padding(.top, 10)
            
            Bio()
                .padding(.horizontal, 43)
                .padding(.top, 10)
        }
    }
    
    @ViewBuilder
    func CoverPhoto() -> some View {
        Image(.sampleCoverPhoto)
            .resizable()
            .frame(width: .width, height: 174)
            .scaledToFill()
            .clipShape(.rect(topLeadingRadius: 10, topTrailingRadius: 10))
    }
    
    @ViewBuilder
    func ProfilePhoto() -> some View {
        ZStack {
            
            CircleDashedBorder(numberOfArcs: 4)
            
            Image(.sampleProduct)
                .resizable()
                .clipShape(.circle)
                .padding(5)
            
            CircleDashedBorder(numberOfArcs: 8)
                .padding(5)

        }
        .frame(width: 88, height: 88)
    }
    
    @ViewBuilder
    func FollowersFavorites() -> some View {
        HStack(spacing: 75) {
            ForEach(0...1, id: \.self) { index in
                NavigationLink {
                    FollowersView(index: index, user: user)
                } label: {
                    VStack {
                        Text(index == 0 ? "\(followersCount)" : "\(favoritesCount)")
                            .foregroundStyle(.textDark)
                            .font(.roboto(type: .bold, size: 22))
                        
                        Text(index == 0 ? "Followers" : "Favorites")
                            .font(.rubik(type: .medium, size: 14))
                            .foregroundStyle(.buttonBlue)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func UserName() -> some View {
        Text(user.fullName)
            .font(.rubik(type: .bold, size: 17))
            .foregroundStyle(.textDark)
    }
    
    @ViewBuilder
    func Bio() -> some View {
        Group {
            Text("BIO: ")
                .font(.rubik(type: .bold, size: 13))
                .foregroundColor(.textDark)
            +
            Text("It’s been a very wonderful time on the today. Best day ever, thanks! ")
                .font(.rubik(type: .regular, size: 13))
            +
            Text("See More...")
                .font(.rubik(type: .regular, size: 13))
                .foregroundColor(.buttonBlue)
        }
        .multilineTextAlignment(.center)
    }
}
