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
        let names = ["Corset", "Cardigan", "Gold", "Silver"]
        PostManager.shared.$posts.receive(on: RunLoop.main).sink { posts in
            
            var categories: [Category] = []
            
            for i in 0 ..< names.count {
                
                let index = i % names.count
                
                let category = names[i]
                
                categories.append(
                    Category(
                        image: Constants.postImages[index],
                        name: category,
                        posts: posts
                    )
                )
            }
            self.categories = categories
        }
        .store(in: &cancellables)
    }
}
