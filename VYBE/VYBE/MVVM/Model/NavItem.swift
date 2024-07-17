//
//  NavItem.swift
//  VYBE
//
//  Created by Hamza Hashmi on 16/07/2024.
//

import Foundation

struct NavItem: Identifiable {
    let id = UUID().uuidString
    let image: ImageResource
    let action: () -> Void
}
