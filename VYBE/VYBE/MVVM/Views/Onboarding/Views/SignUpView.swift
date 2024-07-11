//
//  SignUpView.swift
//  VYBE
//
//  Created by Hamza Hashmi on 10/07/2024.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel = SignUpViewModel()
    
    @State private var agreeTerms = false
    
    var body: some View {
        
        ZStack {
            
            ScrollView {
                
                VStack(spacing: 0) {
                    
                    Text("Sign Up")
                        .foregroundStyle(.textDark)
                        .font(.rubik(type: .medium, size: 28))
                        .padding(.top, 18)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 12) {
                        
                        ValidatorTextFieldView(
                            textField: $viewModel.userName,
                            title: "User Name",
                            errorMessage: viewModel.userNameError
                        )
                        
                        ValidatorTextFieldView(
                            textField: $viewModel.fullName,
                            title: "Full Name",
                            errorMessage: viewModel.fullNameError
                        )
                        
                        ValidatorTextFieldView(
                            textField: $viewModel.phone,
                            title: "Phone",
                            errorMessage: viewModel.phoneError
                        )
                        
                        ValidatorTextFieldView(
                            textField: $viewModel.email,
                            title: "Email Address",
                            errorMessage: viewModel.emailError
                        )
                        
                        ValidatorTextFieldView(
                            textField: $viewModel.password,
                            title: "Password",
                            errorMessage: viewModel.passwordError,
                            isSecureText: true
                        )
                        
                        ValidatorTextFieldView(
                            textField: $viewModel.confirmPassword,
                            title: "Confirm Password",
                            errorMessage: viewModel.confirmPasswordError,
                            isSecureText: true
                        )
                        
                        ValidatorTextFieldView(
                            textField: $viewModel.dob,
                            title: "Date of Birth",
                            errorMessage: viewModel.dobError,
                            keyboardType: .numberPad
                        )
                        
                        ValidatorTextFieldView(
                            textField: $viewModel.cityAndCountry,
                            title: "City and Country",
                            errorMessage: viewModel.cityCountryError
                        )
                        
                        HStack {
                            Button(action: {
                                agreeTerms.toggle()
                            }, label: {
                                Label("By signing up you agree to our Terms of Use and Privacy Policy", systemImage: agreeTerms ? "checkmark.square" : "square")
                                    .font(.roboto(type: .regular, size: 13))
                                    .foregroundColor(agreeTerms ? .textDark : .textLightGray)
                            })
                            
                            Spacer()
                        }
                    }
                    .padding(.top, 26)
                    
                    Spacer()
                    
                    AppButton(title: "Sign up") {
                        viewModel.signup(isAgreed: agreeTerms)
                    }
                    .frame(height: 52)
                    
                    Spacer()
                    
                    HStack {
                        
                        Text("Already have account?")
                            .font(.rubik(type: .regular, size: 13))
                        
                        Button {
                            self.dismiss()
                        } label: {
                            Text("Log in")
                        }
                        .font(.rubik(type: .medium, size: 13))
                    }
                    .foregroundStyle(.textDark)
                    .padding(.bottom, 40)
                }
                .padding(.horizontal, 22)
            }
            
            if viewModel.isLoading {
                ProgressView("Signin Up...")
                    .shadow(radius: 5)
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    self.dismiss()
                }, label: {
                    Image(.back)
                })
            }
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.isPresentAlert) {
            
        }
    }
}
