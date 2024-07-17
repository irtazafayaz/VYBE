//
//  HomeViewModel.swift
//  VYBE
//
//  Created by Hamza Hashmi on 17/07/2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var users: [UserProfile] = []
    
    @Published var posts: [Post] = []
    
    @Published var selectedFilter: FilterType = .Women
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.fetchData()
    }
    
    private func fetchData() {
        UserManager.shared.$users.receive(on: RunLoop.main).sink { [weak self] users in
            self?.users = users
        }
        .store(in: &cancellables)
        
        PostManager.shared.$posts.receive(on: RunLoop.main).sink { [weak self] posts in
            self?.posts = posts
        }
        .store(in: &cancellables)
    }
}
