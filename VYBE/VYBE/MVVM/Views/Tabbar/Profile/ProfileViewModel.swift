//
//  ProfileViewModel.swift
//  VYBE
//
//  Created by Irtaza Fiaz on 18/07/2024.
//

import Foundation
import Combine

class ProfileViewModel: BaseViewModel {
    
    @Published var userProfile: UserProfile? = nil
    
    @Published var collections: [ProfileCollection] = [
        ProfileCollection(img: .samplePost1, title: "Modern Clothes"),
        ProfileCollection(img: .samplePost2, title: "Diorama"),
        ProfileCollection(img: .sampleBag1, title: "Road Trips")
    ]
    
    @Published var isPresentLogout = false
    @Published var isPresentSettings = false
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var collectionTitle = ""
//    @Published var collections = ["Home Decor","Home Decor 1","Home Decor 2","Home Decor 3"]
    
    override init() {
        super.init()
        self.fetchProfile()
    }
    
    private func fetchProfile() {
        UserManager.shared.$userProfile.receive(on: RunLoop.main).sink { [weak self] userProfile in
            self?.userProfile = userProfile
        }
        .store(in: &cancellables)
        
        UserManager.shared.$isLoading.receive(on: RunLoop.main).sink { [weak self] isLoading in
            self?.isLoading = isLoading
        }
        .store(in: &cancellables)
    }
}


extension ProfileViewModel {
    
    func addCollection() {
        guard !collectionTitle.isEmpty else {return}
        if let alreadyExist = self.collections.first(where: {$0.title == collectionTitle}) {
           showAlert(error: "Collection with same name already exist")
        } else {
            collections.insert(ProfileCollection(img: .samplePost1, title: collectionTitle), at: 0)
            collectionTitle = ""
        }
    }
    
    func deleteCollection(collection:ProfileCollection) {
        if let index = self.collections.firstIndex(where: {$0.title == collection.title}) {
            self.collections.remove(at: index)
        }
    }
}
