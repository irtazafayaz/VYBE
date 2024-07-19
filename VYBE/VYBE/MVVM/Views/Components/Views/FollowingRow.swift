//
//  FollowingRow.swift
//  VYBE
//
//  Created by Hamza Hashmi on 19/07/2024.
//

import Foundation
import SwiftUI

struct FollowingRow: View {
    
    let user: UserProfile
    
    let rowHeight: CGFloat
    
    var body: some View {
        HStack(spacing: 0) {
            Image(Constants.sampleImages.randomElement()!)
                .resizable()
                .frame(width: rowHeight, height: rowHeight)
                .aspectRatio(contentMode: .fill)
                .clipShape(.circle)
            
            VStack {
                Text(user.fullName)
                    .font(.roboto(type: .medium, size: 13))
                    .foregroundStyle(.textDark)
                
                Text("@\(user.userName)")
                    .font(.roboto(type: .regular, size: 10))
                    .foregroundStyle(.textLightGray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 15)
            
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 0.5)
                    .foregroundStyle(.buttonBlue)
                
                Text("Following")
                    .font(.roboto(type: .regular, size: 12))
                    .foregroundStyle(.black)
            }
            .frame(width: 90, height: 28)
        }
    }
}
