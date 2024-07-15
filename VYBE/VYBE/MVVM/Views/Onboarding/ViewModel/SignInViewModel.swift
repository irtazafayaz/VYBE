//
//  SignInViewModel.swift
//  VYBE
//
//  Created by Hamza Hashmi on 10/07/2024.
//

import Foundation
import Combine

class SignInViewModel: BaseViewModel {
    
    @Published var email = UserDefaults.standard.email ?? String()
    
    @Published var password = UserDefaults.standard.password ?? String()
    
    @Published var emailError: String? = nil
    
    @Published var passwordError: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        self.$email
            .drop(while: { email in
                return email.isEmpty
            })
            .receive(on: RunLoop.main)
            .sink { [weak self] email in
                self?.emailError = if email.isEmpty {
                    "please Enter Email"
                }
                else if !email.isValidEmail() {
                    "Please Enter Correct Email Adreess"
                }
                else {
                    nil
                }
            }
            .store(in: &cancellables)
        
        self.$password
            .drop(while: { password in
                return password.isEmpty
            })
            .receive(on: RunLoop.main)
            .sink { [weak self] password in
                self?.passwordError = if password.isEmpty {
                    "Please Enter Password"
                }
                else if !password.isValidPassword() {
                    "Password must contain atleast 1 uppercase, 1 lowercase and 1 character, your password must be greater than 6 character"
                }
                else {
                    nil
                }
            }
            .store(in: &cancellables)
    }
    
    func signIn(rememberMe: Bool) {
        
        guard emailError == nil, passwordError == nil else {
            return
        }
        
        self.isLoading = true
        
        Task { @MainActor in
            do {
                try await AuthManager.shared.signIn(email: email, password: password)
                
                UserDefaults.standard.email = rememberMe ? email : nil
                UserDefaults.standard.password = rememberMe ? password : nil
            }
            catch {
                self.showAlert(error: error)
            }
            self.isLoading = false
        }
    }
    
    func signInAnonymous() {
        self.isLoading = true
        
        Task { @MainActor in
            do {
                try await AuthManager.shared.signInAnonymous()
            }
            catch AuthError.emptyFields {
                self.showAlert(error: "Fields can not be empty")
            }
            catch {
                self.showAlert(error: error)
            }
            self.isLoading = false
        }
    }
    
    func forgotPassword() {
        self.isLoading = true
        
        Task { @MainActor in
            do {
                try await AuthManager.shared.forgotPassword(email: email)
            }
            catch {
                self.showAlert(error: error)
            }
            self.isLoading = false
        }
    }
}
