//
//  TextViews.swift
//  VYBE
//
//  Created by Hamza Hashmi on 16/07/2024.
//

import Foundation
import SwiftUI

struct BlueRobotoText: View {
    
    let title: String
    let fontWeight: FontType
    let fontSize: CGFloat
    
    var body: some View {
        Text(title)
            .foregroundStyle(.buttonBlue)
            .font(.roboto(type: fontWeight, size: fontSize))
    }
}
