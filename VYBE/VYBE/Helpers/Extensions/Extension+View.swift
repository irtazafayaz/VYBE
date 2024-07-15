//
//  Extension+View.swift
//  VYBE
//
//  Created by Hamza Hashmi on 14/07/2024.
//

import Foundation
import SwiftUI

extension View {
    
    @ViewBuilder
    func addBackButton(with dismiss: DismissAction) -> some View {
        self
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: dismiss.callAsFunction, label: {
                        Image(.back)
                    })
                }
            }
    }
    
    @ViewBuilder
    func showLoader(isLoading: Bool, title: String = "") -> some View {
        ZStack {
            self
            
            if isLoading {
                ProgressView(title)
            }
        }
    }
}
