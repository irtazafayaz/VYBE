//
//  ManageCollectionView.swift
//  VYBE
//
//  Created by Macbook 5 on 7/19/24.
//

import SwiftUI

struct ManageCollectionView:View {
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var vm:ProfileViewModel
    
    @State var showEditSheet = false
    
    var isUpdate = false
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                AddCollectionView
                    .padding(.vertical,20)
                AddButton
                    .padding(.bottom,15)
                HStack {
                    Text("List of Collections")
                        .font(.roboto(type: .bold, size: 13))
                        .foregroundStyle(.textLightGray.opacity(0.9))
                    Rectangle().foregroundStyle(.textLightGray.opacity(0.2)).frame(height: 1)
                }
               
                ScrollView {
                    LazyVStack {
                       
                        ForEach(vm.collections,id:\.title) {  c in
                            CollectionRow(text: c)
                                .padding(.vertical,4)
                        }
                    }
                   
                }
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ChevronBackButtonAction(action: {
                    dismiss()
                }, title: isUpdate ? "Update Collections" : "Collections")
            }
        }
       
    }
    
    var AddCollectionView:some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    Text("Product Collection")
                        .foregroundStyle(.buttonBlue)
                        .font(.roboto(type: .bold, size: 13))
                    Text("*")
                        .foregroundStyle(.red)
                        .font(.roboto(type: .medium, size: 13))
                    Spacer()
                }
                
                
                ZStack {
                    RoundedRectangle(cornerRadius: 7)
                        .strokeBorder(.textDark, lineWidth: 1.0)
                    
                    TextField("", text: $vm.collectionTitle)
                        .font(.roboto(type: .medium, size: 15))
                        .padding(.horizontal)
                        .foregroundColor(.textDark)
                }
                .frame(height: 50)
            }
        }
        .frame(height: 78)
    }
    
    var AddButton:some View {
        Button {
            vm.addCollection()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .fill(.buttonBlue)
                
                Text(isUpdate ? "Update Collection" : "Add Collection")
                    .font(.roboto(type: .bold, size: 15))
                    .foregroundColor(.white)
            }
            .frame(height: 50)
        }
        
    }
    
    func CollectionRow(text:ProfileCollection) -> some View {
        return ZStack {
            RoundedRectangle(cornerRadius: 7)
                .fill(.textLightGray.opacity(0.1))
                .shadow(radius: 1.7,x:0,y:0)
            
            HStack {
                Image("cl-icon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 19,height: 19)
                
                Text(text.title)
                    .font(.roboto(type: .medium, size: 15))
                    .foregroundColor(.textDark)
                
                Spacer()
                HStack {
                    Button {
                        vm.deleteCollection(collection: text)
                    } label: {
                        Image("trash-icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15,height: 15)
                    }

                    
                    Rectangle()
                        .fill(.lightBackground)
                        .frame(width: 1)
                    
                    Button {
                        showEditSheet.toggle()
                    } label: {
                        Image("edit-icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 17,height: 17)
                    }
                    
                }
                .frame(width: 49,height: 22)
            }
            .padding(.horizontal)
        }
        .frame(height: 42.5)
        .sheet(isPresented: $showEditSheet) {
            EditCollectionView(showSheet: $showEditSheet, text: text)
                .presentationDetents([.height(223)])
        }
        .alert(isPresented: $vm.isPresentAlert, content: {
            Alert(title: Text(vm.alertTitle))
        })
    }
}
