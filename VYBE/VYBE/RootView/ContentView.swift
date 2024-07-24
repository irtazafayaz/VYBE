//
//  ContentView.swift
//  VYBE
//
//  Created by Hamza Hashmi on 09/07/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var contentVM = ContentViewModel()
    
    var body: some View {
        ZStack {
            if contentVM.showSplash {
                SplashView()
            } else if contentVM.showOnboarding {
                SignInView()
            } else {
                TabbarView()
            }
        }
    }
}

#Preview {
    ContentView()
}
