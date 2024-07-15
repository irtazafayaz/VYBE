//
//  TabbarView.swift
//  VYBE
//
//  Created by Hamza Hashmi on 16/07/2024.
//

import Foundation
import SwiftUI

struct TabbarView: View {
    
    @State private var index = 0
    
    private let items: [ImageResource] = [.home, .category, .circlePlus, .heart, .profile]
    
    private let tabIndicatorWidth: CGFloat = .width / 5
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $index) {
                Text("Home")
                    .tag(0)
                
                Text("Category")
                    .tag(1)
                
                Text("Add")
                    .tag(2)
                
                Text("Favorites")
                    .tag(3)
                
                Text("Profile")
                    .tag(4)
            }
            .frame(maxHeight: .infinity)
//            VStack {
                HStack {
                    ForEach(0 ..< items.count, id: \.self) { index in
                        TabbarItem(image: items[index], tabIndex: index)
                    }
                }
//                TabIndicator()
//            }
        }
    }
    
    @ViewBuilder
    func TabbarItem(image: ImageResource, tabIndex: Int) -> some View {
        VStack {
            Image(image)
                .renderingMode(tabIndex == 2 ? .original : .template)
                .foregroundStyle(self.index == tabIndex ? Color.black : .gray)
                .frame(maxWidth: .infinity, alignment: .center)
                .onTapGesture {
                    withAnimation(.bouncy) {
                        self.index = tabIndex
                    }
                }
            if tabIndex == self.index {
                Image(.tabbarIndicator)
            }
        }
    }
    /*
    @ViewBuilder
    func TabIndicator() -> some View {
        HStack {
            
            if self.index == 1 {
                Spacer()
            }
            else if self.index == 2 {
                Spacer()
                Spacer()
            }
            else if self.index == 3 {
                Spacer()
                Spacer()
                Spacer()
            }
            else if self.index == 4 {
                Spacer()
            }
            
            Image(.tabbarIndicator)
                .resizable()
                .frame(width: 25, height: 3)
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 24)

            if self.index == 0 {
                Spacer()
            }
            else if self.index == 1 {
                Spacer()
                Spacer()
                Spacer()
            }
            else if self.index == 2 {
                Spacer()
                Spacer()
            }
            else if self.index == 3 {
                Spacer()
            }
        }
        .frame(width: .width)

    }
     */
}
