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
                    
                    HStack(spacing: 20) {
                        EditButton(title: "Edit Profile", icon: .editProfile, action: {
                            
                        })
                        EditButton(title: "Manage Collection", icon: .manageCollection, action: {
                            
                        })
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
                VStack {
                    Text(index == 0 ? "253" : "255")
                        .foregroundStyle(.textDark)
                        .font(.roboto(type: .bold, size: 22))
                    
                    Text(index == 0 ? "Followers" : "Favorites")
                        .font(.rubik(type: .medium, size: 14))
                        .foregroundStyle(.buttonBlue)
                }
            }
        }
    }
    
    @ViewBuilder
    func UserName() -> some View {
        Text(viewModel.userProfile?.fullName ?? "Loading Name")
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
    
    @ViewBuilder
    func EditButton(title: String, icon: ImageResource, action: @escaping () -> Void) -> some View {
        Button(action: action) {
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
