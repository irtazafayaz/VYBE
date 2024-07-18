//
//  AddPostView.swift
//  VYBE
//
//  Created by Macbook 5 on 7/17/24.
//

import SwiftUI
import PhotosUI

struct AddPostView:View {
    
    @StateObject var vm = AddViewModel()
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedTab:Int
   
    @FocusState var isInputActive: Bool
    
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    
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
            
            .onChange(of: selectedItems) { items in
                Task {
                    selectedImages.removeAll()
                    
                    for item in selectedItems {
                        if let image = try? await item.loadTransferable(type: Image.self) {
                            selectedImages.append(image)
                        }
                    }
                }
            }
        }
        .overlay {
            if vm.showSuccess {
                PostSuccessView(isPresented: $vm.showSuccess, selectedTab: $selectedTab)
            }
        }
        
    }
    
    var AddImageView:some View {
        return ZStack {
            HStack {
                PhotosPicker(selection: $selectedItems) {
                    if let image = selectedImages.first {
                        image
                            .resizable()
                            .scaledToFit()
                    } else {
                        VStack {
                            Image("add-img-icon")
                            Text("Click to Add Image")
                                .foregroundStyle(.buttonBlue)
                                .font(.roboto(type: .medium, size: 13))
                            
                        }
                        .frame(height:258)
                    }
                }
            }
        }
        
        .frame(maxWidth: .infinity,maxHeight: 258)
        .background {
            GeometryReader { geo in
                let strokeWidth: CGFloat = 1
                let radius: CGFloat = 30
                let insettedDiameter = radius * 2 - strokeWidth
                let desiredDash: CGFloat = 10
                let perimeter = (geo.size.width - strokeWidth / 2 - insettedDiameter) * 2 + // horizontal straight edges
                (geo.size.height - strokeWidth / 2 - insettedDiameter) * 2 + // vertical straight edges
                (insettedDiameter * .pi)
                let floored = floor(perimeter / desiredDash)
                let adjustedDash = (perimeter - desiredDash * floored) / floored + desiredDash
                
                RoundedRectangle(cornerRadius: radius)
                    .strokeBorder(style: StrokeStyle(lineWidth: strokeWidth, dash: [adjustedDash]))
                    .foregroundColor(Color.bgLight)
            }
        }
    }
    
    var ProductImageView:some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Select Product Images")
                    .foregroundStyle(.black)
                    .font(.roboto(type: .medium, size: 13))
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(0..<selectedImages.count,id:\.self) { i in
                            ProductRowView(image: selectedImages[i])
                        }
                        PlusButton()
                    }
                }
            }
        }
        .frame(height: 151)
    }
    
    
    func ProductRowView(image:Image) -> some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 7.15)
                    .strokeBorder(.buttonBlue, lineWidth: 1.0)
                    .frame(width: 81.36,height: 77.78)
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 65,height: 63)
                    .cornerRadius(7.15)
            }
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 7.15)
                        .strokeBorder(.buttonBlueLight.opacity(0.5), lineWidth: 0.98)
                        .frame(width: 81.36,height: 29)
                    Text("Affiliate Link")
                        .foregroundStyle(.textDark.opacity(0.5))
                        .font(.roboto(type: .medium, size: 10.74))
                }
            }
        }
        .frame(height: 116)
    }
    
    func PlusButton() -> some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 7.15)
                    .strokeBorder(.buttonBlue, lineWidth: 1.0)
                    .frame(width: 81.36,height: 77.78)
                
                PhotosPicker(selection: $selectedItems) {
                    Image("plus-icon")
                }
            }
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 7.15)
                        .strokeBorder(.buttonBlueLight.opacity(0.5), lineWidth: 0.98)
                        .frame(width: 81.36,height: 29)
                }
            }
            .opacity(0)
        }
        .frame(height: 116)
    }
    
    
    var PostDescView:some View {
        ZStack {
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
        }
        .frame(height: 164)
    }
    
    var ProductTagView:some View {
        ZStack {
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
                            ForEach(vm.tags,id:\.self) { tag in
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
        }
        .frame(height: 78)
    }
    
    
    func TagView(tag:String,onTapCross: @escaping (() -> ())) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundStyle(Color.bgLight.opacity(0.2))
            HStack(spacing: 0) {
                Text(tag)
                    .foregroundStyle(.black)
                    .font(.roboto(type: .regular, size: 12))
                    .padding(.leading,11)
                Spacer()
                Button(action:onTapCross, label: {
                    Image("cross-icon")
                })
                .padding(.trailing,9)
            }
            
        }
        .frame(width: 47 + tag.widthOfString(usingFont: UIFont.roboto(type: .regular, size: 12)),height: 26)
    }
    
    
    var PostButton:some View {
        Button {
            vm.showSuccess.toggle()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .fill(.buttonBlue)
                Text("Post It")
                    .foregroundStyle(.white)
                    .font(.roboto(type: .semiBold, size: 15))
            }
            .frame(width: 163,height: 53)
           
        }
        .padding(.vertical)
    }
}


