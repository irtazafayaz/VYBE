//
//  LandingView.swift
//  VYBE
//
//  Created by Hamza Hashmi on 09/07/2024.
//

import SwiftUI

struct LandingView: View {
        
    @StateObject private var router = OnboardingRouter()
    
    @State private var selectedLanguage = "English"
    
    @State private var selectedCountryIndex = 0
    
    let languages = ["English", "Arabic", "French", "Spanish"]
    
    let countryFlags = ["🇦🇪"]
    
    let countries = ["UAE"]
    
    var body: some View {
        
        NavigationStack(path: $router.path) {
            
            VStack {
                
                Image(.logoText)
                    .padding(.top, 47)
                
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Neque,")
                    .font(.rubik(type: .regular, size: 13))
                    .foregroundStyle(.textLight)
                    .padding(.horizontal, 25)
                
                VStack(spacing: 18) {
                    ForEach(languages, id: \.self) { language in
                        Button {
                            self.selectedLanguage = language
                        } label: {
                            LanguageRow(title: language, isSelected: selectedLanguage == language)
                        }
                    }
                }
                .padding(.top, 46)
                
                Spacer()
                
                CountriesSelector()
                
                Spacer()
                
                AppButton(title: "Next") {
                    router.push(path: .signIn)
                }
                .frame(height: 52)
                .padding(.bottom, 27)
            }
            .padding(.horizontal, 27)
            .navigationDestination(for: OnboardingPath.self) { onboardingPath in
                
                switch onboardingPath {
                case .signIn:
                    SignInView()
                    
                case .signUp:
                    SignUpView()
                    
                case .forgotPassword:
                    ForgotPasswordView()
                }
            }
        }
        .environmentObject(router)
    }
    
    @ViewBuilder
    func LanguageRow(title: String, isSelected: Bool) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke()
                .foregroundStyle(Color.textDark)
            
            if isSelected {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(Color.textLight)
                    .opacity(0.1)
                    .padding(1)
            }
            
            Text(title)
                .foregroundStyle(.textDark)
        }
        .frame(height: 52)
    }
    
    @ViewBuilder
    func CountriesSelector() -> some View {
        Menu {
            ForEach(0..<countries.count, id: \.self) { index in
                Button("\(countryFlags[index]) \(countries[index])") {
                    self.selectedCountryIndex = index
                }
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .stroke()
                    .foregroundStyle(Color.textDark)
                
                HStack {
                    HStack(spacing: 12) {
                        Text(countryFlags[selectedCountryIndex])
                        Text(countries[selectedCountryIndex])
                    }
                    .font(.roboto(type: .bold, size: 13))
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                }
                .foregroundStyle(.textDark)
                .padding(.horizontal)
            }
            .frame(height: 52)

//            CountryRow(flagEmoji: countryFlags[selectedCountryIndex], countryName: countries[selectedCountryIndex])
        }
    }
//    func CountryRow(flagEmoji: String, countryName: String) -> some View {
//    }
}

#Preview {
    LandingView()
}
