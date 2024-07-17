//
//  PostSuccessView.swift
//  VYBE
//
//  Created by Macbook 5 on 7/17/24.
//

import SwiftUI

struct PostSuccessView:View {
    
    @Binding var isPresented:Bool
    @Binding var selectedTab:Int
    @State var scale = 0.5
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack {
                Image("success-check")
                Text("Post Submitted")
                    .foregroundStyle(.black)
                    .font(.roboto(type: .semiBold, size: 40))
                Text("Aliquet ut cum integer sed lorem integer.")
                    .foregroundStyle(.textDark.opacity(0.6))
                    .font(.roboto(type: .medium, size: 15))
                Button {
                    isPresented.toggle()
                    selectedTab = 0
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 7)
                            .fill(.buttonBlue)
                        Text("Back to home")
                            .foregroundStyle(.white)
                            .font(.roboto(type: .semiBold, size: 15))
                    }
                    .frame(width: 163,height: 53)
                   
                }
                .padding(.vertical)

            }
            .scaleEffect(scale)
        }
       
        .onAppear(perform: {
            withAnimation {
                scale = 1
            }
        })
       
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }
}
