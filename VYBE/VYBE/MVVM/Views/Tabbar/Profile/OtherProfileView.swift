//
//  OtherProfileView.swift
//  VYBE
//
//  Created by Irtaza Fiaz on 19/07/2024.
//

import Foundation
import SwiftUI

struct OtherProfileView: View {
    
    let user: UserProfile
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 20) {
                
                ProfileTopHeader(
                    user: user,
                    followersCount: 253,
                    favoritesCount: 255
                )

                FollowButton()
                
                Divider()
            }
            
//            ProfileToolBar(fullName: user.fullName)
        }
    }
    
    @ViewBuilder
    func FollowButton() -> some View {
        Button {
            
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.buttonBlue)
                
                Text("Follow")
                    .foregroundStyle(.offWhite)
                    .font(.roboto(type: .bold, size: 11))
            }
            .frame(height: 43)
            .padding(.horizontal, 23)
        }

    }
}
