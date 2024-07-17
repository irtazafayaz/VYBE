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
    
    @ViewBuilder
    func addLeftNavItems(items: [NavItem]) -> some View {
        self.toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack {
                    ForEach(0..<items.count, id: \.self) { index in
                        Button(action: items[index].action, label: {
                            Image(items[index].image)
                        })
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func addRightNavItems(items: [NavItem]) -> some View {
        self.toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    ForEach(0..<items.count, id: \.self) { index in
                        Button(action: items[index].action, label: {
                            Image(items[index].image)
                        })
                    }
                }
            }
        }
    }
}

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
