//
//  ContentViewModel.swift
//  VYBE
//
//  Created by Hamza Hashmi on 09/07/2024.
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    
    @Published var showSplash = true
    
    init() {
        self.hideSplash()
    }
    
    private func hideSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                self.showSplash = false
            }
        }
    }
}
