//
//  ProfileView.swift
//  VYBE
//
//  Created by Hamza Hashmi on 18/07/2024.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            
            ProfileToolBar(fullName: viewModel.userProfile?.fullName)
            
            ScrollView {
                
                VStack(spacing: 0) {
                    
                    // Cover + Profile
                    ProfileTopHeader(
                        userName: viewModel.userProfile?.fullName,
                        followersCount: 253,
                        favoritesCount: 255
                    )
                                        
                    HStack(spacing: 20) {
                        
                        if let user = viewModel.userProfile {
                            NavigationLink {
                                EditProfileView(user: user)
                            } label: {
                                EditButton(title: "Edit Profile", icon: .editProfile)
                            }
                        }

                        NavigationLink {
                            
                        } label: {
                            EditButton(title: "Manage Collection", icon: .manageCollection)
                        }
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 12)
                    
                    BlueRobotoText(title: "Collection", fontWeight: .medium, fontSize: 14)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 12)
                        .padding(.top, 22)
                    
                    HStack(spacing: 6) {
                        ForEach(viewModel.collections) { collection in
                            CollectionCell(collection: collection)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.top, 3)
                    
                    BlueRobotoText(title: "Latest Post", fontWeight: .medium, fontSize: 14)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.leading, .top], 12)

                    HStack(spacing: 6) {
                        ForEach(viewModel.collections) { collection in
                            CollectionCell(collection: collection)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.top, 3)

                }
                .padding(.top, 10)
            }
        }
    }
    
    
    @ViewBuilder
    func EditButton(title: String, icon: ImageResource) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 0.5)
                .foregroundStyle(.buttonBlue)
                .opacity(0.6)
            
            HStack(spacing: 12) {
                Image(icon)
                
                BlueRobotoText(title: title, fontWeight: .bold, fontSize: 11)
            }
        }
        .frame(height: 45)
    }
    
    @ViewBuilder
    func CollectionCell(collection: ProfileCollection) -> some View {
        let width = getColumnWidth(horizontalPadding: 24, spacing: 6, numberOfColumns: 3)

        VStack {

            Image(collection.img)
                .resizable()
                .frame(width: width, height: width)
                .clipShape(.rect(cornerRadius: 7.5))
            
            Text(collection.title)
                .foregroundStyle(.textDark)
                .font(.roboto(type: .medium, size: 11))
        }
//        .frame(width: width, height: width)
    }
}

struct ProfileToolBar: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let fullName: String?
    
    var body: some View {
        
        ZStack {}
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    ChevronBackButton(dismiss: dismiss, title: fullName)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        Button(action: {
                            
                        }, label: {
                            Image(.notification)
                        })
                        
                        MenuButton()
                    }
                }
            }
    }
    
    func MenuButton() -> some View {
        Menu {
            Button(action: {
                
            }, label: {
                Label("Settings", image: "setting")
            })
            
            Button {
                
            } label: {
                Label("Logout", image: "logout")
            }


        } label: {
            Image(systemName: "ellipsis")
                .foregroundColor(.buttonBlue)
                .rotationEffect(.degrees(90))
        }
    }
}
