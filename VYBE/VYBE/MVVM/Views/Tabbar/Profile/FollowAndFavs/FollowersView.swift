//
//  FollowersView.swift
//  VYBE
//
//  Created by Hamza Hashmi on 19/07/2024.
//

import Foundation
import SwiftUI

struct FollowersView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var index: Int
    
    let user: UserProfile
    
    let followers = UserManager.shared.users.shuffled()
    
    let following = UserManager.shared.users.shuffled()
    
    var body: some View {
        ScrollView {
            HStack {
                TabItem(title: "Followers", tabIndex: 0)
                
                TabItem(title: "Following", tabIndex: 1)
            }
            .padding(.top, 34)

            TabIndicator()
                .padding(.top, 14)
            
            VStack(spacing: 21) {
                ForEach(index == 0 ? followers : following) { user in
                    if index == 0 {
                        FollowersRow(user: user, rowHeight: 46)
                    }
                    else {
                        FollowingRow(user: user, rowHeight: 46)
                    }
                }
            }
            .padding(.horizontal, 26)
            .padding(.vertical, 18)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ChevronBackButton(dismiss: dismiss, title: user.fullName)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(.search)
                }
            }
        }
    }
    
    @ViewBuilder
    func TabItem(title: String, tabIndex: Int) -> some View {
        Group {
            if tabIndex == index {
                BlueRobotoText(title: title, fontWeight: .medium, fontSize: 14)
            }
            else {
                Text(title)
                    .foregroundStyle(.textDark)
                    .font(.roboto(type: .medium, size: 14))
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.bottom, 13)
        .onTapGesture {
            withAnimation {
                index = tabIndex
            }
        }
    }
    
    @ViewBuilder
    func TabIndicator() -> some View {
        HStack {
            
            if index == 1 {
                Spacer()
            }
            
            Rectangle()
                .fill(.buttonBlue)
                .frame(width: .width / 2, height: 1)
            
            if index == 0 {
                Spacer()
            }
        }
    }
}
