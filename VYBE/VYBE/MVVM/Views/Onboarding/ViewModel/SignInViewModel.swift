//
//  SignInViewModel.swift
//  VYBE
//
//  Created by Irtaza Fiaz on 10/07/2024.
//

import Foundation
import Combine

class SignInViewModel: BaseViewModel {
    
    @Published var email = UserDefaults.standard.email ?? ""
    @Published var password = UserDefaults.standard.password ?? ""
    @Published var emailError: String? = nil
    @Published var passwordError: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        
        validateEmail()
        validatePassword()
    }
    
    private func validateEmail() {
        self.$email
            .dropFirst()
            .receive(on: RunLoop.main)
            .map { email -> String? in
                if email.isEmpty {
                    return "Please Enter Email"
                } else if !email.isValidEmail() {
                    return "Please Enter Correct Email Address"
                } else {
                    return nil
                }
            }
            .assign(to: &$emailError)
    }
    
    private func validatePassword() {
        self.$password
            .dropFirst()
            .receive(on: RunLoop.main)
            .map { password -> String? in
                if password.isEmpty {
                    return "Please Enter Password"
                } else if !password.isValidPassword() {
                    return "Password must contain at least 1 uppercase, 1 lowercase, 1 character, and be greater than 6 characters"
                } else {
                    return nil
                }
            }
            .assign(to: &$passwordError)
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
            } catch {
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
            } catch AuthError.emptyFields {
                self.showAlert(error: "Fields cannot be empty")
            } catch {
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
            } catch {
                self.showAlert(error: error)
            }
            self.isLoading = false
        }
    }

}
