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
    
    @Published var groupedNotifications: [NotificationGroup] = []
    
    @Published var showNotification = false
    @Published var showManageCollection = false
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var collectionTitle = ""
    @Published var collections = ["Home Decor","Home Decor 1","Home Decor 2","Home Decor 3"]
    
    init() {
        self.fetchData()
        self.groupNotifications()
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
    
    private func groupNotifications() {
          let allNotifications = NotificationModel.all()
          let groupedDictionary = Dictionary(grouping: allNotifications) { notification -> Date in
              let calendar = Calendar.current
              return calendar.startOfDay(for: notification.date)
          }
          let sortedKeys = groupedDictionary.keys.sorted(by: >)
          self.groupedNotifications = sortedKeys.map { key in
              NotificationGroup(date: key, notifications: groupedDictionary[key]!)
          }
      }
    
}

extension HomeViewModel {
    
    func addCollection() {
        guard !collectionTitle.isEmpty else {return}
        if !collections.contains(collectionTitle) {
            collections.insert(collectionTitle, at: 0)
            collectionTitle = ""
        }
    }
    
    func deleteCollection(text:String) {
        if let index = self.collections.firstIndex(of: text) {
            self.collections.remove(at: index)
        }
    }
}
