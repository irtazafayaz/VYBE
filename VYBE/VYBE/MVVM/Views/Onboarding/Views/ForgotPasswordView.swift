//
//  ForgotPasswordView.swift
//  VYBE
//
//  Created by Hamza Hashmi on 12/07/2024.
//

import Foundation
import SwiftUI

struct ForgotPasswordView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel = SignInViewModel()
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Text("Forgot Password")
                .foregroundStyle(.textDark)
                .font(.rubik(type: .medium, size: 28))
                .padding(.top, 18)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("A message will be sent to your email address with further instructions")
                .foregroundStyle(.textLight)
                .font(.roboto(type: .regular, size: 14))
            
            ValidatorTextFieldView(textField: $viewModel.email, title: "Email Address", keyboardType: .emailAddress)
            
            AppButton(title: "Recover Password") {
                viewModel.forgotPassword()
            }
            .padding(.horizontal, 5)
            .frame(height: 52)
            
            Spacer()
        }
        .addBackButton(with: dismiss)
        .showLoader(isLoading: viewModel.isLoading)
        .padding(.horizontal, 25)
    }
}
