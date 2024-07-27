//
//  PostViewFull.swift
//  VYBE
//
//  Created by Irtaza Fiaz on 18/07/2024.
//

import Foundation
import SwiftUI

struct PostViewFull: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let post: Post
    
    var body: some View {
        ScrollView {
            
            VStack(spacing: 0) {
                
                Divider()
                    .padding(.top, 7)
  
                // TODO: Irtaza
                
//                PostView(post: post, showSeeMore: false, showUserView: false)
                
                SeeMorePosts()
                    .padding(.horizontal, 15)
                    .padding(.bottom, 10)
                
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2), content: {
                    ForEach(PostManager.shared.posts) { post in
                        
                        let width = getColumnWidth(horizontalPadding: 30, spacing: 15, numberOfColumns: 2)
                        
                        if let postImage = post.images.randomElement() {
                            Image(postImage)
                                .resizable()
                                .frame(width: width, height: width * 1.5)
                                .aspectRatio(contentMode: .fill)
                                .clipShape(.rect(cornerRadius: 7))
                        }
                    }
                })
                .padding(.horizontal, 15)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: dismiss.callAsFunction, label: {
                        HStack(spacing: 12) {
                            
                            ChevronBackButton(dismiss: dismiss)
                            
                            Image(post.userImage)
                                .resizable()
                                .frame(width: 34, height: 34)
                                .clipShape(.circle)
                            
                            BlueRobotoText(title: post.user.fullName, fontWeight: .medium, fontSize: 14)
                            
                            Spacer()
                        }
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        
                        Button(action: {}, label: {
                            MenuButton(title: "Edit Post", systemImage: "square.and.pencil")
                        })
                        
                        Button(action: {}, label: {
                            MenuButton(title: "Delete Post", systemImage: "trash")
                        })
                    } label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(90))
                            .foregroundStyle(.buttonBlue)
                    }
                }
            })
        }
    }
    
    @ViewBuilder
    func MenuButton(title: String, systemImage: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: systemImage)
            
            Text(title)
                .font(.rubik(type: .regular, size: 11))
            
            Spacer()
        }
        .foregroundStyle(.buttonBlue)
    }
    
    @ViewBuilder
    func SeeMorePosts() -> some View {
        HStack(spacing: 0) {
            BlueRobotoText(title: "See more posts from ", fontWeight: .medium, fontSize: 14)
            
            BlueRobotoText(title: post.user.fullName, fontWeight: .bold, fontSize: 14)
                .italic(true)
            
            Spacer()
        }
    }
}
