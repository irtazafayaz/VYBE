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
    
    @StateObject private var loginVM = LoginViewModel()
    
    @State private var rememberMe = false
    
    let socialIcons: [ImageResource] = [.apple, .fb, .google]
    
    var body: some View {
        
        VStack {
            
            Text("Sign In")
                .foregroundStyle(.textDark)
                .font(.rubik(type: .medium, size: 28))
                .padding(.top, 60)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ValidatorTextFieldView(textField: $loginVM.email, title: "Email", errorMessage: loginVM.emailError, keyboardType: .emailAddress)
            
            ValidatorTextFieldView(textField: $loginVM.password, title: "Password", errorMessage: loginVM.passwordError, keyboardType: .default, isSecureText: true)
            
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
            
            AppButton(title: "Sign In") {
                
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
                    Divider()
                        .frame(width: 23, height: 0.5)
                    
                    Text("OR")
                        .font(.roboto(type: .regular, size: 13))
                    
                    Divider()
                        .frame(width: 23, height: 0.5)
                }
                
                Button {
                    
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
            .padding(.top, 40)
            
            Spacer()
            
            HStack {
                
                Text("Don’t have an account?")
                    .font(.rubik(type: .regular, size: 13))

                Button {
                    
                } label: {
                    Text("Register Here")
                }
                .font(.rubik(type: .medium, size: 13))

            }
            .foregroundStyle(.textDark)
            .padding(.bottom)
        }
        .padding(.horizontal, 22)
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
