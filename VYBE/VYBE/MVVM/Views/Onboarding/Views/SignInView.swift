//
//  SignInView.swift
//  VYBE
//
//  Created by Hamza Hashmi on 10/07/2024.
//

import Foundation
import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject private var router: OnboardingRouter
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel = SignInViewModel()
    
    @State private var rememberMe = false
    
    let socialIcons: [ImageResource] = [.apple, .fb, .google]
    
    var body: some View {
        
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
                    
                    Button(action: {
                        router.push(path: .forgotPassword)
                    }, label: {
                        Text("Forgot Password?")
                            .font(.roboto(type: .regular, size: 13))
                            .foregroundColor(.textLight)
                    })
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
                    
                    Button {
                        viewModel.signInAnonymous()
                    } label: {
                        Text("Continue As Guest User")
                            .padding(.horizontal)
                            .foregroundStyle(.offWhite)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(.buttonBlueLight)
                            }
                    }
                }
                .padding(.top, 45)
                
                Spacer()
                
                HStack {
                    
                    Text("Don’t have an account?")
                        .font(.rubik(type: .regular, size: 13))
                    
                    Button {
                        router.push(path: .signUp)
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
