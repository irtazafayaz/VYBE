//
//  SettingsSheet.swift
//  VYBE
//
//  Created by Hamza Hashmi on 20/07/2024.
//

import Foundation
import SwiftUI

struct SettingsSheet: View {
    
    @State private var isDisableAccount = false
    
    var body: some View {
        VStack {
            
            Text("Settings")
                .font(.roboto(type: .medium, size: 16))
                .foregroundStyle(.textDark)
            
            HStack {
                
                Text("Disable Account")
                    .font(.roboto(type: .regular, size: 17))
                    .foregroundStyle(.textLight)
                
                Spacer()
                
                Toggle("", isOn: $isDisableAccount)
            }
        }
        .padding(.horizontal, 20)
        .presentationDetents([.height(104)])
        .presentationDragIndicator(.visible)
    }
}
