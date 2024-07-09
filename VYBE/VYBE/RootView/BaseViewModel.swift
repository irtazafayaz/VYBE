//
//  BaseViewModel.swift
//  VYBE
//
//  Created by Hamza Hashmi on 09/07/2024.
//

import Foundation

class BaseViewModel: NSObject, ObservableObject {
    
    @Published var showAlert = false
    
    @Published var errorMsg = ""
    
    @Published var isLoading = false
    

    func showError(error: Error) {
        DispatchQueue.main.async {
            self.showAlert = true
            self.errorMsg = error.localizedDescription
        }
        debugPrint(error)
    }
    
    func showError(error: String) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.showAlert = true
            self.errorMsg = error
        }
        debugPrint(error)
    }
    
    func hideError() {
        DispatchQueue.main.async {
            self.showAlert = false
            self.errorMsg = ""
        }
    }
}
