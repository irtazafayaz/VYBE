//
//  BaseViewModel.swift
//  VYBE
//
//  Created by Irtaza Fiaz on 09/07/2024.
//

import Foundation

class BaseViewModel: NSObject, ObservableObject {
    
    @Published var isPresentAlert = false
    
    @Published var alertTitle = ""
    
    @Published var isLoading = false

    func showAlert(error: Error) {
        DispatchQueue.main.async {
            self.isPresentAlert = true
            self.alertTitle = error.localizedDescription
        }
        debugPrint(error)
    }
    
    func showAlert(error: String) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.isPresentAlert = true
            self.alertTitle = error
        }
        debugPrint(error)
    }
    
    func hideAlert() {
        DispatchQueue.main.async {
            self.isPresentAlert = false
            self.alertTitle = ""
        }
    }
}
