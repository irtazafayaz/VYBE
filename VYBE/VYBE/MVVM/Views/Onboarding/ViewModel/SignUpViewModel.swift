//
//  SignUpViewModel.swift
//  VYBE
//
//  Created by Hamza Hashmi on 11/07/2024.
//

import Foundation
import Combine

class SignUpViewModel: BaseViewModel {
    
    // Fields:
    
    @Published var userName = String()
    
    @Published var fullName = String()
    
    @Published var phone = String()
    
    @Published var email = String()
    
    @Published var password = String()
    
    @Published var confirmPassword = String()
    
    @Published var dob = String()
    
    @Published var cityAndCountry = String()
    
    // Errors:
    
    @Published var userNameError: String? = nil
    
    @Published var fullNameError: String? = nil

    @Published var phoneError: String? = nil

    @Published var emailError: String? = nil

    @Published var passwordError: String? = nil

    @Published var confirmPasswordError: String? = nil
    
    @Published var dobError: String? = nil
    
    @Published var cityCountryError: String? = nil
    
    private var cancellables = Set<AnyCancellable>()

    override init() {
        super.init()
        
        self.$userName
            .drop(while: { value in
                return value.isEmpty
            })
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                self?.userNameError = value.isEmpty ? "Please Enter User Name" : nil
            }
            .store(in: &cancellables)
        
        self.$fullName
            .drop(while: { value in
                return value.isEmpty
            })
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                self?.fullNameError = value.isEmpty ? "Please Enter Fullname" : nil
            }
            .store(in: &cancellables)

        self.$phone
            .drop(while: { value in
                return value.isEmpty
            })
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                self?.phoneError = value.count < 6 ? "Please Enter Correct Phone Number" : nil
            }
            .store(in: &cancellables)
        
        self.$email
            .drop(while: { value in
                return value.isEmpty
            })
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                self?.emailError = value.isValidEmail() ? nil : "Please Enter Correct Email Address"
            }
            .store(in: &cancellables)

        self.$password
            .drop(while: { value in
                return value.isEmpty
            })
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                self?.passwordError = value.isValidPassword() ? nil : "Password must contain atleast 1 uppercase, 1 lowercase and 1 character, your password must be greater than 6 character"
            }
            .store(in: &cancellables)

        self.$confirmPassword
            .drop(while: { value in
                return value.isEmpty
            })
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                self?.confirmPasswordError = self?.confirmPassword == self?.password ? nil : "Passwords do not match"
            }
            .store(in: &cancellables)
        
        self.$dob
            .drop(while: { value in
                return value.isEmpty
            })
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                self?.dobError = self?.dob == nil ? "Date of Birth Can not be empty" : nil
            }
            .store(in: &cancellables)

    }
    
    func signup(isAgreed: Bool) {
        guard userNameError == nil,
              fullNameError == nil,
              phoneError    == nil,
              emailError    == nil,
              passwordError == nil,
              confirmPasswordError == nil,
              dobError == nil,
              cityCountryError == nil else {
            return
        }
        
        guard isAgreed else {
            self.showAlert(error: "Please Agree our Terms of Use And Privacy Policy")
            return
        }
        
        self.isLoading = true
        
        Task { @MainActor in
            do {
                try await AuthManager.shared.signUp(
                    userName: userName,
                    fullName: fullName,
                    phone: phone,
                    email: email,
                    dob: dob,
                    cityAndCountry: cityAndCountry,
                    password: password,
                    confirmPassword: confirmPassword
                )
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
}
