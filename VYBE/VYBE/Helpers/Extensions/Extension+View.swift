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
    func ArrowBackButton(dismiss: DismissAction) -> some View {
        Button(action: dismiss.callAsFunction, label: {
            Image(.back)
        })
    }
    
    @ViewBuilder
    func ChevronBackButton(dismiss: DismissAction, title: String? = nil) -> some View {
        
        Button(action: dismiss.callAsFunction, label: {
            
            HStack {
                
                Image(.chevron)
                
                if let title {
                    BlueRobotoText(title: title, fontWeight: .bold, fontSize: 15)
                }
            }
        })
    }
    
    @ViewBuilder
    func ChevronBackButtonAction(action: @escaping (() -> ()), title: String? = nil) -> some View {
        
        Button(action: action, label: {
            
            HStack {
                
                Image(.chevron)
                
                if let title {
                    BlueRobotoText(title: title, fontWeight: .bold, fontSize: 15)
                }
            }
        })
    }
    
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
                            if let image = items[index].image {
                                Image(image)
                            }
                            if let text = items[index].title {
                                Text(text)
                                    .font(.roboto(type: .bold, size: 15))
                                    .foregroundStyle(.buttonBlue)
                            }
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
                            if let image = items[index].image {
                                Image(image)
                            }
                            if let text = items[index].title {
                                Text(text)
                                    .font(.roboto(type: .bold, size: 15))
                            }
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
