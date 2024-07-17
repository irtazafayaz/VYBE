//
//  CategoryViewModel.swift
//  VYBE
//
//  Created by Hamza Hashmi on 17/07/2024.
//

import Foundation
import Combine

class CategoryViewModel: BaseViewModel {
    
    @Published var categories: [Category] = []
    
//    @Published var path: [CategoryPath] = []
    
//    @Published var selectedCategory: Category? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        self.fetchCategories()
    }
    
    private func fetchCategories() {
        PostManager.shared.$posts.receive(on: RunLoop.main).sink { posts in
            var categories: [Category] = []
            for category in ["Corset", "Cardigan", "Gold", "Silver"] {
                categories.append(Category(image: Constants.sampleImages.randomElement()!, name: category, posts: posts))
            }
            self.categories = categories
        }
        .store(in: &cancellables)
    }
}
