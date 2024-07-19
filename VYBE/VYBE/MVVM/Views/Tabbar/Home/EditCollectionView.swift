//
//  EditCollectionView.swift
//  VYBE
//
//  Created by Macbook 5 on 7/19/24.
//

import SwiftUI

struct EditCollectionView:View {
    
    @Binding var showSheet:Bool
    
    @EnvironmentObject var vm:HomeViewModel
    
    var text:String
    
    
    
    var body: some View {
        ZStack {
            Color.white
            VStack() {
                ZStack {
                    Circle().fill(.red)
                    Image("warn-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20,height: 18)
                }
                .frame(width: 54,height: 54)
                
                Text("Do you wish to delete this Collection?")
                    .foregroundStyle(.textDark)
                    .font(.roboto(type: .regular, size: 13))
                    .padding(.vertical)
                
                HStack {
                    CancelButton
                        .padding(.trailing,7)
                    DeleteButton
                        .padding(.leading,7)
                }
            }
        }
    }
    
    var CancelButton:some View {
        Button {
            showSheet.toggle()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .fill(.textLightGray.opacity(0.2))
                
                Text("Cancel")
                    .font(.roboto(type: .regular, size: 14.5))
                    .foregroundColor(.textDark)
            }
            .frame(width: 147,height: 48)
        }
        
    }
    
    var DeleteButton:some View {
        Button {
            showSheet.toggle()
            vm.deleteCollection(text: text)
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 7)
                    .fill(.buttonBlue)
                
                Text("Delete")
                    .font(.roboto(type: .medium, size: 14.5))
                    .foregroundColor(.white)
            }
            .frame(width: 147,height: 48)
        }
        
    }
}
