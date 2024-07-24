//
//  SignInView.swift
//  VYBE
//
//  Created by Hamza Hashmi on 10/07/2024.
//

import Foundation
import SwiftUI

struct SignInView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var router = OnboardingRouter()
    @StateObject private var viewModel = SignInViewModel()
    
    @State private var rememberMe = false
    @State private var openRegisterView: Bool = false
    
    let socialIcons: [ImageResource] = [.google]
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                
                VStack(spacing: 0) {
                    
                    Text("Sign In")
                        .foregroundStyle(.textDark)
                        .font(.rubik(type: .medium, size: 28))
                        .padding(.top, 18)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 12) {
                        
                        ValidatorTextFieldView(textField: $viewModel.email, title: "Email", errorMessage: viewModel.emailError, keyboardType: .emailAddress)
                        
                        ValidatorTextFieldView(textField: $viewModel.password, title: "Password", errorMessage: viewModel.passwordError, keyboardType: .default, isSecureText: true)
                    }
                    .padding(.top, 19)
                    
                    HStack {
                        Button(action: {
                            rememberMe.toggle()
                        }, label: {
                            Label("Remember Me", systemImage: rememberMe ? "checkmark.square" : "square")
                                .font(.roboto(type: .regular, size: 13))
                                .foregroundColor(rememberMe ? .textDark : .textLightGray)
                        })
                        
                        Spacer()
                    }
                    .padding(.top, 12)
                    
                    AppButton(title: "Sign In") {
                        viewModel.signIn(rememberMe: rememberMe)
                    }
                    .frame(height: 52)
                    .padding(.top, 60)
                    
                    VStack(spacing: 26) {
                        
                        HStack(spacing: 15) {
                            ForEach(socialIcons, id: \.self) { icon in
                                SocialIcon(image: icon)
                            }
                        }
                        
                        HStack(spacing: 9) {
                            Rectangle()
                                .frame(width: 23, height: 0.5)
                            
                            Text("OR")
                                .font(.roboto(type: .regular, size: 13))
                            
                            Rectangle()
                                .frame(width: 23, height: 0.5)
                        }
                        .foregroundStyle(Color.textLightGray)

                    }
                    .padding(.top, 45)
                    
                    Spacer()
                    
                    HStack {
                        
                        Text("Don’t have an account?")
                            .font(.rubik(type: .regular, size: 13))
                        
                        Button {
                            openRegisterView.toggle()
                        } label: {
                            Text("Register Here")
                        }
                        .font(.rubik(type: .medium, size: 13))
                        
                    }
                    .foregroundStyle(.textDark)
                    .padding(.bottom, 40)
                }
                .padding(.horizontal, 22)
                .toolbar(.hidden, for: .navigationBar)
                
                if viewModel.isLoading {
                    ProgressView("Signing In ...")
                        .shadow(radius: 20)
                }
            }
            .alert(viewModel.alertTitle, isPresented: $viewModel.isPresentAlert) {
                
            }
            .navigationDestination(isPresented: $openRegisterView, destination: {
                SignUpView()
                    .toolbar(.hidden)
            })
        }
    }
    
    @ViewBuilder
    func SocialIcon(image: ImageResource) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke()
                .foregroundStyle(.lightBackground)
            
            Image(image)
        }
        .frame(width: 52, height: 52)
        .shadow(color: .black.opacity(0.05), radius: 4)
    }
}
