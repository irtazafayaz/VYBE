//
//  FavoritesView.swift
//  VYBE
//
//  Created by Hamza Hashmi on 17/07/2024.
//

import Foundation
import SwiftUI

struct FavoritesView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel = FavoritesViewModel()
    
    let imgWidth: CGFloat = .width
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                VStack(spacing: 0, content: {
                    
                    BlueRobotoText(title: "Your Favorites", fontWeight: .bold, fontSize: 15)
                        .underline()
                        .padding(.top, 18)
                    
                    HStack {
                        TabItem(title: "Post", tabIndex: 0)
                        
                        TabItem(title: "Item", tabIndex: 1)
                    }
                    .padding(.top, 22)
                    
                    TabIndicator()
                    
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 18), count: 3), spacing: 23, content: {
                        
                        let width = getColumnWidth(horizontalPadding: 37, spacing: 18, numberOfColumns: 3)
                        
                        if viewModel.index == 0 {
                            ForEach(0 ..< viewModel.favoritePosts.count, id: \.self) { index in
                                let post = viewModel.favoriteItems[index]
                                NavigationLink {
                                    PostViewFull(post: post)
                                } label: {
                                    if let postImage = post.images.first {
                                        Image(postImage)
                                            .resizable()
                                            .frame(width: width, height: width)
                                            .aspectRatio(contentMode: .fill)
                                            .clipShape(.rect(cornerRadius: 5))
                                    }
                                }
                            }
                        }
                        else {
                            ForEach(0 ..< viewModel.favoriteItems.count, id: \.self) { index in
                                let item = viewModel.favoriteItems[index]
                                if let itemImage = item.images.randomElement() {
                                    Image(itemImage)
                                        .resizable()
                                        .frame(width: width, height: width)
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(.rect(cornerRadius: 5))
                                }
                            }
                        }
                    })
                    .padding(.horizontal, 25)
                    .padding(.top, 25)
                })
            }
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    ChevronBackButton(dismiss: dismiss, title: "Back to Home")
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}, label: {
                        Image(.search)
                    })
                }
            }
        }
    }
    
    @ViewBuilder
    func TabItem(title: String, tabIndex: Int) -> some View {
        Group {
            if tabIndex == viewModel.index {
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
                viewModel.index = tabIndex
            }
        }
    }
    
    @ViewBuilder
    func TabIndicator() -> some View {
        HStack {
            
            if viewModel.index == 1 {
                Spacer()
            }
            
            Rectangle()
                .fill(.buttonBlue)
                .frame(width: .width / 2, height: 1)
            
            if viewModel.index == 0 {
                Spacer()
            }
        }
    }
}
