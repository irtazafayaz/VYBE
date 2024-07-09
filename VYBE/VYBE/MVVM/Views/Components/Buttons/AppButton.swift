//
//  AppButton.swift
//  VYBE
//
//  Created by Hamza Hashmi on 10/07/2024.
//

import Foundation
import SwiftUI

struct AppButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
    
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .foregroundStyle(Color.buttonBlue)
                
                Text(title)
                    .foregroundStyle(.offsetWhite)
                    .font(.roboto(type: .bold, size: 14))
            }
        }
    }
}
