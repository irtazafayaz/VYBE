//
//  AddPostView.swift
//  VYBE
//
//  Created by Macbook 5 on 7/17/24.
//

import SwiftUI
import PhotosUI

struct AddPostView: View {
    @StateObject var vm = AddViewModel()
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedTab: Int
    
    @FocusState private var isInputActive: Bool
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                ScrollView {
                    VStack(spacing: 20) {
                        AddImageView
                        ProductImageView
                        PostDescView
                        ProductTagView
                        PostButton
                        Spacer().frame(height: 20)
                    }
                    .padding(.horizontal)
                }
                .focused($isInputActive)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Button("Cancel") {
                            isInputActive = false
                        }
                        Spacer()
                        Button("Done") {
                            isInputActive = false
                            vm.addTag()
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    ChevronBackButtonAction(action: {
                        selectedTab = 0
                    }, title: "Back to Home")
                }
            }
            .onChange(of: vm.selectedItems) { items in
                Task {
                    vm.selectedUiImages = await loadImages(from: items)
                }
            }
        }
        .overlay {
            if vm.showSuccess {
                PostSuccessView(isPresented: $vm.showSuccess, selectedTab: $selectedTab)
            }
        }
    }
    
    private func loadImages(from items: [PhotosPickerItem]) async -> [UIImage] {
        await withTaskGroup(of: UIImage?.self) { group in
            for item in items {
                group.addTask {
                    do {
                        if let imageData = try await item.loadTransferable(type: Data.self), let image = UIImage(data: imageData) {
                            return image
                        } else {
                            return nil
                        }
                    } catch {
                        print("Failed to load image: \(error)")
                        return nil
                    }
                }
            }
            
            var images: [UIImage] = []
            for await image in group {
                if let image = image {
                    images.append(image)
                }
            }
            return images
        }
    }
    
    private var PostButton: some View {
        Button {
            Task {
                await vm.addNewPost()
            }
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .fill(.buttonBlue)
                Text("Post It")
                    .foregroundStyle(.white)
                    .font(.roboto(type: .bold, size: 15))
            }
            .frame(width: 163, height: 53)
        }
        .padding(.vertical)
    }

    private var AddImageView: some View {
        ZStack {
            HStack {
                PhotosPicker(selection: $vm.selectedItems) {
                    if let image = vm.selectedUiImages.first {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    } else {
                        VStack {
                            Image("add-img-icon")
                            Text("Click to Add Image")
                                .foregroundStyle(.buttonBlue)
                                .font(.roboto(type: .medium, size: 13))
                        }
                        .frame(height: 258)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 258)
        .background {
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: 30)
                    .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [10]))
                    .foregroundColor(Color.bgLight)
            }
        }
    }
    
    private var ProductImageView: some View {
        VStack(alignment: .leading) {
            Text("Select Product Images")
                .foregroundStyle(.black)
                .font(.roboto(type: .medium, size: 13))
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(vm.selectedUiImages, id: \.self) { image in
                        ProductRowView(image: image)
                    }
                    PlusButton()
                }
            }
        }
        .frame(height: 151)
    }
    
    private func ProductRowView(image: UIImage) -> some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 7.15)
                    .strokeBorder(.buttonBlue, lineWidth: 1.0)
                    .frame(width: 81.36, height: 77.78)
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 65, height: 63)
                    .cornerRadius(7.15)
            }
            Button {
                // Add action
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 7.15)
                        .strokeBorder(.buttonBlueLight.opacity(0.5), lineWidth: 0.98)
                        .frame(width: 81.36, height: 29)
                    Text("Affiliate Link")
                        .foregroundStyle(.textDark.opacity(0.5))
                        .font(.roboto(type: .medium, size: 10.74))
                }
            }
        }
        .frame(height: 116)
    }
    
    private func PlusButton() -> some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 7.15)
                    .strokeBorder(.buttonBlue, lineWidth: 1.0)
                    .frame(width: 81.36, height: 77.78)
                PhotosPicker(selection: $vm.selectedItems) {
                    Image("plus-icon")
                }
            }
            Button {
                // Add action
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 7.15)
                        .strokeBorder(.buttonBlueLight.opacity(0.5), lineWidth: 0.98)
                        .frame(width: 81.36, height: 29)
                }
            }
            .opacity(0)
        }
        .frame(height: 116)
    }
    
    private var PostDescView: some View {
        VStack(alignment: .leading) {
            Text("Post Description")
                .foregroundStyle(.buttonBlue)
                .font(.roboto(type: .medium, size: 13))
            
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(.textDark, lineWidth: 1.0)
                
                TextEditor(text: $vm.desc)
                    .foregroundStyle(.black)
                    .font(.roboto(type: .regular, size: 13))
                    .padding()
                    .disabled(vm.desc.count >= 500)
            }
            .frame(height: 111)
            
            HStack {
                Spacer()
                Text("\(vm.desc.count)/500")
                    .foregroundStyle(.black.opacity(0.2))
                    .font(.roboto(type: .regular, size: 10))
            }
        }
        .frame(height: 164)
    }
    
    private var ProductTagView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Product Tags")
                    .foregroundStyle(.buttonBlue)
                    .font(.roboto(type: .medium, size: 13))
                Text("*")
                    .foregroundStyle(.red)
                    .font(.roboto(type: .medium, size: 13))
                Spacer()
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(.textDark, lineWidth: 1.0)
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(vm.tags, id: \.self) { tag in
                            TagView(tag: tag) {
                                if let index = vm.tags.firstIndex(of: tag) {
                                    vm.tags.remove(at: index)
                                }
                            }
                        }
                        
                        TextField("Latest", text: $vm.newTag)
                            .font(.roboto(type: .regular, size: 12))
                            .focused($isInputActive)
                    }
                    .padding(.horizontal)
                }
            }
            .frame(height: 50)
        }
        .frame(height: 78)
    }
    
    private func TagView(tag: String, onTapCross: @escaping () -> Void) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(Color.bgLight.opacity(0.2))
            HStack(spacing: 0) {
                Text(tag)
                    .foregroundStyle(.black)
                    .font(.roboto(type: .regular, size: 12))
                    .padding(.leading, 11)
                Spacer()
                Button(action: onTapCross) {
                    Image("cross-icon")
                }
                .padding(.trailing, 9)
            }
        }
        .frame(width: 47 + tag.widthOfString(usingFont: UIFont.roboto(type: .regular, size: 12)), height: 26)
    }
    
}
