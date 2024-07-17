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
        VStack {
            UserRow()
                .padding(.top, 10)
                .padding(.horizontal, 15)
            
            TextView()
            
            ImagesView()
            
            SeeMore()
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
            
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 12, height: 12)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    func TextView() -> some View {
        VStack {
            Text(post.description)
                .font(.roboto(type: .regular, size: 13))
                .foregroundStyle(.textDark)
        }
    }
    
    @ViewBuilder
    func ImagesView() -> some View {
        VStack {
            
            if let firstImage = post.images.first {
                Image(firstImage)
                    .resizable()
                    .frame(width: .width, height: .width * 0.61)
            }
            
            if post.images.count > 3 {
                LazyVGrid(columns: columns) {
                    ForEach(numberOfSmallImages, id: \.self) { index in
                        if let image = post.images[safe: index] {
                            Image(image)
                                .resizable()
                                .frame(width: smallImgWidth, height: smallImgWidth * 1.1)
//                                .aspectRatio(contentMode: .fill)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func SeeMore() -> some View {
        HStack {
            Rectangle()
                .stroke(style: StrokeStyle(dash: [5]))
            
            Text("See More")
            
            Rectangle()
                .stroke(style: StrokeStyle(dash: [5]))
        }
    }
}
