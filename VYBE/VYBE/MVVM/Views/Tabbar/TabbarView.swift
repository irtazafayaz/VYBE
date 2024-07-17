//
//  TabbarView.swift
//  VYBE
//
//  Created by Hamza Hashmi on 16/07/2024.
//

import Foundation
import SwiftUI

struct TabbarView: View {
    
    @State private var index = 1
    
    private let items: [ImageResource] = [.home, .category, .circlePlus, .heart, .profile]
    
    private let tabIndicatorWidth: CGFloat = .width / 5
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $index) {
                HomeView()
                    .tag(0)
                    .toolbar(.hidden, for: .tabBar)
                
                CategoryView()
                    .tag(1)
                    .toolbar(.hidden, for: .tabBar)
                
                AddPostView(selectedTab: $index)
                    .tag(2)
                    .toolbar(.hidden, for: .tabBar)
                Text("Favorites")
                    .tag(3)
                
                Text("Profile")
                    .tag(4)
            }
            .frame(maxHeight: .infinity)
            
            HStack {
                ForEach(0 ..< items.count, id: \.self) { index in
                    TabbarItem(image: items[index], tabIndex: index)
                }
            }
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
