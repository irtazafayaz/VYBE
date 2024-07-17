//
//  HomeView.swift
//  VYBE
//
//  Created by Hamza Hashmi on 16/07/2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var homeVM = HomeViewModel()
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                ScrollView {
                    
                    VStack(spacing: 0) {
                        
                        UserYouFollowed()
                            .padding(.top, 10)
                        
                        PopularUsers()
                            .padding(.top, 10)
                        
                        FilterButtons()
                            .padding([.horizontal, .top], 20)
                        
                        VStack(spacing: 0) {
                            ForEach(homeVM.posts) { post in
                                PostView(post: post, showSeeMore: true)
                            }
                        }
                        .padding(.vertical, 22)
                    }
                }
            }
            .addLeftNavItems(items: [
                NavItem(image: .menu, action: {
                    
                })
            ])
            .addRightNavItems(items: [
                NavItem(image: .search, action: {
                    
                }),
                NavItem(image: .notification, action: {
                    
                })
            ])
        }
    }
    
    @ViewBuilder
    func UserYouFollowed() -> some View {
        VStack(spacing: 7) {
            
            HStack {
                BlueRobotoText(title: "User You Followed", fontWeight: .medium, fontSize: 14)
                Spacer()
                BlueRobotoText(title: "See All", fontWeight: .medium, fontSize: 12)
            }
            .padding(.horizontal, 20)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0 ..< homeVM.users.count, id: \.self) { index in
                        if let user = homeVM.users[safe: index] {
                            CircleUserView(
                                user: user,
                                circleSize: 60,
                                showFollowButton: false,
                                showPlusButton: index == 0,
                                sampleImage: Constants.sampleImages.randomElement()!
                            )
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .scrollIndicators(.hidden)
        }
    }
    
    @ViewBuilder
    func PopularUsers() -> some View {
        VStack(spacing: 7) {
            
            HStack {
                
                BlueRobotoText(title: "Popular User’s", fontWeight: .medium, fontSize: 14)
                
                Spacer()
                
                BlueRobotoText(title: "See All", fontWeight: .medium, fontSize: 12)
            }
            .padding(.horizontal, 15)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0 ..< homeVM.users.count, id: \.self) { index in
                        if let user = homeVM.users[safe: index] {
                            CircleUserView(
                                user: user,
                                circleSize: 60,
                                showFollowButton: true,
                                showPlusButton: false,
                                sampleImage: Constants.sampleImages.randomElement()!
                            )
                        }
                    }
                }
                .padding(.horizontal, 15)
            }
            .scrollIndicators(.hidden)
        }
    }
    
    @ViewBuilder
    func FilterButtons() -> some View {
        HStack(spacing: 11) {
            ForEach(FilterType.allCases, id: \.rawValue) { filter in
                Text(filter.rawValue)
                    .font(.roboto(type: .medium, size: 11))
                    .foregroundStyle(homeVM.selectedFilter == filter ? .white : .textLight)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
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
