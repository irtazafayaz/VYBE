//
//  PostView.swift
//  VYBE
//
//  Created by Hamza Hashmi on 17/07/2024.
//

import Foundation
import SwiftUI

struct PostView: View {
    
    let post: Post
    
    let showSeeMore: Bool
    
    @State private var isSeeMorePressed = false
    
    private let columns = Array(repeating: GridItem(), count: 3)
    
    var numberOfSmallImages: Range<Int> {
        let fullRange = 1 ..< post.images.count
        let halfRange = 1 ..< 3
        return isSeeMorePressed ? fullRange : halfRange
    }
    
    var smallImgWidth: CGFloat {
        let width: CGFloat = (.width - 26 - 20) / 3 //( width - padding - spacing) / 3
        return width
    }
    
    var body: some View {
        VStack(spacing: 0) {
            UserRow()
                .padding(.top, 10)
                .padding(.horizontal, 15)
            
            TextView()
                .padding(.top, 13)
                .padding(.horizontal, 15)
            
            ImagesView()
                .padding(.top, 6)
            
            SeeMore()
                .padding(.top, 8)
                .padding(.horizontal, 15)
                .padding(.bottom, 13)
        }
    }
    
    @ViewBuilder
    func UserRow() -> some View {
        HStack(alignment: .top, spacing: 6) {
            Image(post.userImage)
                .resizable()
                .frame(width: 43, height: 43)
                .aspectRatio(contentMode: .fill)
                .clipShape(.circle)
                .padding(.trailing, 6)
            
            VStack(alignment: .leading) {
                Text(post.user.fullName)
                    .font(.roboto(type: .medium, size: 14))
                    .foregroundStyle(.buttonBlue)
                
                Text(post.postedTime.getTimeAgo())
            }
            
            Image(.blueCheckmark)
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 12, height: 12)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    func TextView() -> some View {
        VStack(alignment: .leading) {
            Text(post.description)
                .font(.roboto(type: .regular, size: 13))
                .foregroundStyle(.textDark)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    func ImagesView() -> some View {
        VStack(spacing: 13) {
            
            if let firstImage = post.images.first {
                ImageView(firstImage, width: .width, height: .width * 0.61)
//                Image(firstImage)
//                    .resizable()
//                    .frame(width: .width, height: .width * 0.61)
            }
            
            if post.images.count > 3 {
                LazyVGrid(columns: columns) {
                    ForEach(numberOfSmallImages, id: \.self) { index in
                        if let image = post.images[safe: index] {
                            ImageView(image, width: smallImgWidth, height: smallImgWidth * 1.1)
//                            Image(image)
//                                .resizable()
//                                .frame(width: smallImgWidth, height: smallImgWidth * 1.1)
//                                .aspectRatio(contentMode: .fill)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
                .padding(.horizontal, 13)
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
            
            
            Text("See More")
                .font(.roboto(type: .semiBold, size: 9))
                .foregroundStyle(.buttonBlue)
        }
    }
    
    @ViewBuilder
    func ImageView(_ image: ImageResource, width: CGFloat, height: CGFloat) -> some View {
        ZStack(alignment: .topTrailing) {
            Image(image)
                .resizable()
                .frame(width: width, height: height)
            
            Image(.heartGrayCircle)
                .padding([.top, .trailing], 18)
        }
    }
}
