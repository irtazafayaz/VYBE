//
//  FavoritesViewModel.swift
//  VYBE
//
//  Created by Irtaza Fiaz on 18/07/2024.
//

import Foundation
import Combine

class FavoritesViewModel: BaseViewModel {
    
    @Published var favoritePosts: [Post] = []
    
    @Published var favoriteItems: [Post] = []
    
    @Published var index = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        self.fetchFavoritePosts()
    }
    
    private func fetchFavoritePosts() {
        PostManager.shared.$posts.receive(on: RunLoop.main).sink { posts in
            self.favoritePosts = posts.shuffled()
            self.favoriteItems = posts.shuffled()
        }
        .store(in: &cancellables)
    }
}
