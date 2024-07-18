//
//  EditProfileView.swift
//  VYBE
//
//  Created by Hamza Hashmi on 19/07/2024.
//

import Foundation
import SwiftUI

struct EditProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var user: UserProfile
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                
                ImageView()
                
                EditTextField(title: "Username", text: $user.userName)
                
                EditTextField(title: "Full Name", text: $user.fullName)
                
                EditTextField(title: "Bio", text: $user.bio)
                
                EditTextField(title: "Email", text: $user.email)
                
                EditTextField(title: "Phone Number", text: $user.phone)

                EditTextField(title: "Date of Birth", text: $user.dob)

                EditTextField(title: "Country", text: $user.cityAndCountry)

                EditTextField(title: "City", text: $user.cityAndCountry)

                EditTextField(title: "City", text: $user.address)
            }
            .padding(.vertical, 25)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ChevronBackButton(dismiss: dismiss, title: user.fullName)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(.buttonBlue)
                    
                    Text("Save")
                        .font(.roboto(type: .medium, size: 11))
                        .foregroundStyle(.offWhite)
                }
                .frame(width: 53, height: 30)
            }
        }
    }
    
    @ViewBuilder
    func ImageView() -> some View {
        ZStack(alignment: .bottomTrailing) {
            
            Circle()
                .fill(.white)
            
            Image(.samplePost)
                .resizable()
                .clipShape(.circle)
                .padding(2)
            
            Image(.cameraCircle)
                .resizable()
                .frame(width: 36, height: 36)
                .offset(x: 2, y: 2)
        }
        .frame(width: 114, height: 114)
    }
    
    @ViewBuilder
    func EditTextField(title: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            
            BlueRobotoText(title: title, fontWeight: .medium, fontSize: 14)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(.textDark)
                
                TextField("", text: text)
                    .padding(.horizontal)
            }
            .frame(height: 50)
        }
        .padding(.horizontal, 15)
    }
}
