//
//  AddViewModel.swift
//  VYBE
//
//  Created by Macbook 5 on 7/17/24.
//

import Foundation
import Combine

class AddViewModel: ObservableObject {

    var cancellables = Set<AnyCancellable>()
    
    @Published var showSuccess = false
    @Published var tags = ["Women","Trending","Wathces"]
    @Published var newTag = ""
    
    @Published var desc = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eu nunc fermentum diam sed scelerisque id. Montes, massa facilisi pharetra nam."
    
    init() {
      
    }
   
    
    func addTag() {
        if !newTag.isEmpty {
            tags.append(newTag)
            newTag = ""
        }
    }
}

