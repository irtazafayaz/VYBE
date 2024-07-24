//
//  NavItem.swift
//  VYBE
//
//  Created by Irtaza Fiaz on 16/07/2024.
//

import Foundation

struct NavItem: Identifiable {
    let id = UUID().uuidString
    let title: String?
    let image: ImageResource?
    let action: () -> Void
    
    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.image = nil
        self.action = action
    }
    
    init(image: ImageResource, action: @escaping () -> Void) {
        self.title = nil
        self.image = image
        self.action = action
    }
}
