//
//  CircleUserView.swift
//  VYBE
//
//  Created by Hamza Hashmi on 16/07/2024.
//

import Foundation
import SwiftUI

struct CircleUserView: View {
    
    let user: UserProfile
    
    let circleSize: CGFloat
    
    let showFollowButton: Bool
    
    let showPlusButton: Bool
    
    let sampleImage: ImageResource
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(sampleImage)
                    .resizable()
                    .frame(width: circleSize, height: circleSize)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(.circle)
                
                if showPlusButton {
                    Image(.plusBubble)
                        .resizable()
                        .frame(width: 18, height: 18)
                        .offset(x: 0, y: 0)
                    
                }
            }
            
            Text(user.fullName)
                .font(.roboto(type: .regular, size: 11.25))
                .foregroundStyle(.textDark)
            
            if showFollowButton {
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(lineWidth: 0.5)
                        .foregroundStyle(.buttonBlue)
                    
                    Text("Follow")
                        .foregroundStyle(.textLight)
                        .font(.roboto(type: .medium, size: 11))
                }
                .frame(width: 60, height: 25)
            }
        }
    }
}
