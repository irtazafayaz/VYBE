//
//  EditProfileView.swift
//  VYBE
//
//  Created by Irtaza Fiaz on 19/07/2024.
//

import SwiftUI

struct EditProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var user: UserProfile
    @State private var isSaving = false
    @State private var openImagePicker = false
    @State private var errorMessage: String? = nil
    @State private var selectedImage: UIImage? = nil
    
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
                EditTextField(title: "Address", text: $user.address)
            }
            .padding(.vertical, 25)
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $openImagePicker) {
            ImagePicker(image: $selectedImage, isShown: $openImagePicker) {}
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ChevronBackButton(dismiss: dismiss, title: user.fullName)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundStyle(.buttonBlue)
                    
                    Button(action: saveProfile) {
                        Text(isSaving ? "Saving..." : "Save")
                            .font(.roboto(type: .medium, size: 11))
                            .foregroundStyle(.offWhite)
                    }
                }
                .frame(width: 53, height: 30, alignment: .center)
            }
        }
    }
    
    // MARK: - Edit Image View -

    @ViewBuilder
    func ImageView() -> some View {
        ZStack(alignment: .bottomTrailing) {
            
            Circle()
                .fill(.white)
            
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(.circle)
                    .padding(2)
            } else if let imageUrl = user.profileImageUrl, let url = URL(string: imageUrl) {
                CachedAsyncImageView(url: url)
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .clipShape(.circle)
                    .padding(2)
            }
            
            Button {
                openImagePicker.toggle()
                
            } label: {
                Image(.cameraCircle)
                    .resizable()
                    .frame(width: 36, height: 36)
                    .offset(x: 2, y: 2)
            }
            
        }
        .frame(width: 114, height: 114)
    }
    
    // MARK: - Edit Text Fields -
    
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
    
    // MARK: - Save Action

    private func saveProfile() {
        isSaving = true
        Task { @MainActor in
            do {
                if let image = selectedImage {
                    let url = try await PostManager.shared.uploadImage(image, path: "/profileImage/\(user.userName)")
                    user.profileImageUrl = url.absoluteString
                }
                try await UserManager.shared.updateUser(userProfile: user)
                isSaving = false
                dismiss()
            } catch {
                isSaving = false
                errorMessage = "Error updating profile: \(error.localizedDescription)"
            }
        }
    }
}

#Preview {
    EditProfileView(user: UserProfile(id: "32"))
}
