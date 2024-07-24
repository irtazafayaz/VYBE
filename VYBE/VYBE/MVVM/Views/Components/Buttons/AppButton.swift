//
//  AppButton.swift
//  VYBE
//
//  Created by Irtaza Fiaz on 10/07/2024.
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
                    .foregroundStyle(.offWhite)
                    .font(.roboto(type: .bold, size: 14))
            }
        }
    }
}
