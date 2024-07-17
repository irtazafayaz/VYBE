//
//  SelectedCategoryView.swift
//  VYBE
//
//  Created by Hamza Hashmi on 17/07/2024.
//

import Foundation
import SwiftUI

struct SelectedCategoryView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let category: Category
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0, content: {
                ForEach(category.posts) { post in
                    PostView(post: post, showSeeMore: true)
                }
            })
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ChevronBackButton(dismiss: dismiss, title: category.name)
            }
        }
    }
}
