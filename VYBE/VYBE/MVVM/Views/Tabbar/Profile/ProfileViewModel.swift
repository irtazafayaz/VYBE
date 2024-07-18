//
//  ProfileViewModel.swift
//  VYBE
//
//  Created by Hamza Hashmi on 18/07/2024.
//

import Foundation
import Combine

class ProfileViewModel: BaseViewModel {
    
    @Published var userProfile: UserProfile? = nil
    
    @Published var collections: [ProfileCollection] = [
        ProfileCollection(img: .samplePost, title: "Modern Clothes"),
        ProfileCollection(img: .samplePostImage2, title: "Diorama"),
        ProfileCollection(img: .sampleProduct, title: "Road Trips")
    ]
    
    private var cancellables = Set<AnyCancellable>()
    
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
