//
//  PostView.swift
//  VYBE
//
//  Created by Irtaza Fiaz on 17/07/2024.
//

import Foundation
import SwiftUI

struct PostView: View {
    @State private var isSeeMorePressed = false
    @State private var userProfile: UserProfile? = nil
    
    let post: FirebasePost
    let showSeeMore: Bool
    var showUserView: Bool = true
    private let columns = Array(repeating: GridItem(), count: 3)
    
    var numberOfSmallImages: Range<Int> {
        let fullRange = 1 ..< (post.images?.count ?? 0)
        let halfRange = 1 ..< 3
        return isSeeMorePressed ? fullRange : halfRange
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            if showUserView {
                UserRow()
                    .padding(.top, 10)
                    .padding(.horizontal, 15)
            }
            
            TextView()
                .padding(.top, 13)
                .padding(.leading, 15)
                .padding(.trailing, 35)
            
            ImagesView()
                .padding(.top, 6)
            
            SeeMore()
                .padding(.top, 8)
                .padding(.horizontal, 15)
                .padding(.bottom, 13)
        }
        .onAppear {
            fetchUserProfile()
        }
        
    }
    
    func fetchUserProfile() {
        post.userRef.getDocument { document, error in
            if let document = document, document.exists {
                self.userProfile = try? document.data(as: UserProfile.self)
            } else {
                print("User not found")
            }
        }
    }
    
    @ViewBuilder
    func UserRow() -> some View {
        HStack(alignment: .center, spacing: 12) {
            
            NavigationLink {
                OtherProfileView(user: post.user)
            } label: {
                if let imageUrl = userProfile?.profileImageUrl, let url = URL(string: imageUrl) {
                    CachedAsyncImageView(url: url)
                        .frame(width: 43, height: 43)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(.circle)
                        .padding(2)
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 43, height: 43)
                        .clipShape(.circle)
                        .padding(2)
                }
            }
            
            VStack(alignment: .leading, spacing: 0) {
                // full name and blue circle
                NavigationLink {
                    OtherProfileView(user: post.user)
                } label: {
                    HStack(spacing: 6) {
                        Text(post.user.fullName)
                            .font(.roboto(type: .medium, size: 14))
                            .foregroundStyle(.buttonBlue)
                        
                        Image(.blueCheckmark)
                    }
                }
                
                // posted ago
                Text(post.postedTime.getTimeAgo())
                    .font(.roboto(type: .regular, size: 10))
                    .foregroundStyle(.buttonBlueLight)
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
                    .foregroundColor(.textDark)
            }
            
        }
    }
    
    @ViewBuilder
    func TextView() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(post.description)
                .font(.roboto(type: .regular, size: 13))
                .foregroundStyle(.textDark)
                .multilineTextAlignment(.leading)
            
            Text("TAGS:")
                .foregroundColor(Color.textDark)
                .font(.roboto(type: .italic, size: 13))
            +
            Text(" #\(post.tags.joined(separator: " #"))")
                .font(.roboto(type: .regular, size: 13))
                .foregroundColor(Color(hexString: "#1CACE3"))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    func ImagesView() -> some View {
        VStack(spacing: 13) {
            
            if let postImages = post.images {
                if let firstImage = postImages.first {
                    ImageView(firstImage, width: .width, height: .width * 0.61, showEditIcon: true)
                }
                
                if postImages.count > 3 {
                    LazyVGrid(columns: columns) {
                        ForEach(numberOfSmallImages, id: \.self) { index in
                            if let image = postImages[safe: index] {
                                
                                let width = getColumnWidth(horizontalPadding: 15, spacing: 15, numberOfColumns: 3)
                                
                                ImageView(image, width: width, height: width * 1.1)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }
                    .padding(.horizontal, 15)
                }
            }
            
            
        }
    }
    
    @ViewBuilder
    func SeeMore() -> some View {
        ZStack {
            
            Line()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                .frame(height: 1)
            
            RoundedRectangle(cornerRadius: 4)
                .foregroundStyle(.white)
                .frame(width: 57, height: 14)
                .shadow(color: .black.opacity(0.25), radius: 10)
            
            Button {
                self.isSeeMorePressed.toggle()
            } label: {
                Text("See More")
                    .font(.roboto(type: .bold, size: 9))
                    .foregroundStyle(.buttonBlue)
            }
        }
    }
    
    @ViewBuilder
    func ImageView(_ image: String, width: CGFloat, height: CGFloat, showEditIcon: Bool = false) -> some View {
        ZStack(alignment: .topTrailing) {
            CachedAsyncImageView(url: URL(string: image)!)
                .frame(width: width, height: height)
            
            Image(.heartGrayCircle)
                .padding([.top, .trailing], 18)
            
        }
    }
}
