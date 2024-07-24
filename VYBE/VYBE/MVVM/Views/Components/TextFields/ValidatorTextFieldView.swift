//
//  ValidatorTextFieldView.swift
//  VYBE
//
//  Created by Irtaza Fiaz on 10/07/2024.
//

import Foundation
import SwiftUI

struct ValidatorTextFieldView: View {
    @Binding var textField: String
    var title: String
    var errorMessage: String?
    var keyboardType: UIKeyboardType = .default
    var isSecureText: Bool = false
    var height: CGFloat = 40

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            CustomTextField(textField: $textField, isPasswordEyeEnabled: isSecureText, height: height, title: title)
                .keyboardType(keyboardType)
            
            if let errorMessage {
                Text(errorMessage)
                    .font(.roboto(type: .regular, size: 12))
                    .foregroundStyle(Color.red)
            }
        }
        .frame(height: 60, alignment: .top)
//        .frame(maxWidth: .infinity)
    }
}

struct CustomTextField: View {
    @Binding var textField: String
    
    var isPasswordEyeEnabled: Bool = false
    var height: CGFloat
    var cornerRadius:CGFloat = 10
    
    @State private var showPassword = false
    
    @FocusState private var isFocused: Bool

    var title: String

    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .stroke(Color.textDark)

            HStack {
                if !isPasswordEyeEnabled || showPassword {
                    TextField(title, text: $textField)
                        .focused($isFocused)
                }
                else {
                    SecureField(title, text: $textField)
                        .focused($isFocused)
                }

                if isPasswordEyeEnabled {
                    Button(action: { showPassword.toggle() }) {
                        Image(systemName: showPassword ? "eye.fill" : "eye.slash.fill")
                            .foregroundColor(Color.textDark)
                    }
                    .padding(.trailing, 8) // Add padding to eye icon
                }
            }
            .font(.roboto(type: .regular, size: 12))
            .padding()
        }
        .frame(height: height)
        
//        VStack(alignment: .leading) {
//            
//            .background(Color.white)
//            .cornerRadius(cornerRadius)
//        }
//        .frame(height: 40)
//        .frame(maxWidth: .infinity, alignment: .leading) // Align content to the left
    }
}
