//
//  ContentViewModel.swift
//  VYBE
//
//  Created by Hamza Hashmi on 09/07/2024.
//

import Foundation
import SwiftUI
import FirebaseAuth

class ContentViewModel: ObservableObject {
    
    @Published var showSplash = true
    
    @Published var showOnboarding = Auth.auth().currentUser == nil
    
    init() {
        self.hideSplash()
        self.listenAuth()
    }
    
    private func listenAuth() {
        Auth.auth().addStateDidChangeListener { auth, user in
            withAnimation {
                self.showOnboarding = user == nil
            }
        }
    }
    
    private func hideSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                self.showSplash = false
            }
        }
    }
}
