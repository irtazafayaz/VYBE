//
//  HomeView.swift
//  VYBE
//
//  Created by Irtaza Fiaz on 16/07/2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var homeVM = HomeViewModel()
    @ObservedObject private var postManager = PostManager.shared
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                ScrollView {
                    
                    VStack(spacing: 0) {
                        
                        TopBar()
                        UserYouFollowed()
                        
                        Divider()
                            .padding(.top, 13)
                        
                        VStack(spacing: 0) {
                            ForEach(postManager.allPosts) { post in
                                PostView(post: post, showSeeMore: true)
                            }
                        }
                        .padding(.bottom, 22)
                    }
                }
                .navigationDestination(isPresented: $homeVM.showNotification) {
                    NotificationView()
                        .environmentObject(homeVM)
                }
            }
            .toolbar(.hidden, for: .navigationBar)

        }
    }
    
    @ViewBuilder
    func TopBar() -> some View {
        HStack {
            Image(.logoText)
                .resizable()
                .frame(width: 63)
                .scaledToFit()
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(height: 54)
        .padding(.leading, 16)
        .padding(.trailing, 14)
    }
    
    @ViewBuilder
    func UserYouFollowed() -> some View {
        VStack(spacing: 7) {
            
            HStack {
                BlueRobotoText(title: "User You Followed", fontWeight: .medium, fontSize: 14)
                Spacer()
            }
            .padding(.horizontal, 15)
            
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(0 ..< homeVM.users.count, id: \.self) { index in
                        if let user = homeVM.users[safe: index] {
                            let imgIndex = index % Constants.userImages.count
                            CircleUserView(
                                user: user,
                                circleSize: 60,
                                showFollowButton: false,
                                showPlusButton: false,
                                sampleImage: Constants.userImages[imgIndex]
                            )
                        }
                    }
                }
                .padding(.horizontal, 15)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.top, 7)
    }
   
    @ViewBuilder
    func FilterButtons() -> some View {
        HStack(spacing: 11) {
            ForEach(FilterType.allCases, id: \.rawValue) { filter in
                Text(filter.rawValue)
                    .font(.roboto(type: .medium, size: 11))
                    .foregroundStyle(homeVM.selectedFilter == filter ? .white : .textLight)
                    .frame(height: 23)
                    .frame(maxWidth: .infinity)
                    .background {
                        if homeVM.selectedFilter == filter {
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundStyle(.buttonBlue)
                        }
                        else {
                            RoundedRectangle(cornerRadius: 4)
                                .stroke()
                                .foregroundStyle(.buttonBlue)
                        }
                    }
                
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
