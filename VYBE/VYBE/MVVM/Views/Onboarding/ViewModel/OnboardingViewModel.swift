//
//  OnboardingViewModel.swift
//  VYBE
//
//  Created by Hamza Hashmi on 10/07/2024.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    @Published var email = String()
    
    @Published var password = String()
    
    @Published var emailError: String? = nil
    
    @Published var passwordError: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
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
}
