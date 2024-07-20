//
//  CategoryView.swift
//  VYBE
//
//  Created by Hamza Hashmi on 17/07/2024.
//

import Foundation
import SwiftUI

struct CategoryView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var categoryVM = CategoryViewModel()
    
    // ( width - padding - spacing) / 3
    private let otherCellWidth: CGFloat = (.width - 40 - 17) / 2
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                
                ScrollView {
                    
                    VStack {
                        
                        TitleView(title: "Most Popular Categories")
                            .padding(.top, 21)
                        
                        PopularCategoriesView()
                            .padding(.top, 13.5)
                        
                        TitleView(title: "Other Categories")
                            .padding(.top, 11)
                        
                        OtherCategoriesView()
                            .padding(.top, 13.5)
                    }
                }
                
            }
            .toolbar(content: {
                
                ToolbarItem(placement: .topBarLeading) {
                    ChevronBackButton(dismiss: dismiss, title: "Back to Home")
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}, label: {
                        Image(.search)
                    })
                }
            })
        }
    }
    
    @ViewBuilder
    func TitleView(title: String) -> some View {
        BlueRobotoText(title: title, fontWeight: .bold, fontSize: 17)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    func PopularCategoriesView() -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 15) {
                ForEach(0 ..< Constants.postImages.count, id: \.self) { index in
                    PopularCategoryCell(
                        image: Constants.postImages[index],
                        imgWidth: 144,
                        imgHeight: 171,
                        title: "Lorem ipsum..."
                    )
                }
            }
            .padding(.horizontal, 20)
        }
        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    func OtherCategoriesView() -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 2),
                  content: {
            ForEach(categoryVM.categories) { category in
                NavigationLink {
                    SelectedCategoryView(category: category)
                } label: {
                    OtherCategoryCell(
                        image: category.image,
                        imgWidth: otherCellWidth,
                        imgHeight: otherCellWidth * 1.01,
                        title: category.name
                    )
                }
            }
        })
        .padding(.horizontal, 20)
    }
}
