//
//  CategoryCell.swift
//  VYBE
//
//  Created by Hamza Hashmi on 17/07/2024.
//

import Foundation
import SwiftUI

struct PopularCategoryCell: View {
    
    let image: ImageResource
    
    let imgWidth: CGFloat
    
    let imgHeight: CGFloat
    
    let title: String
    
    var body: some View {
        
        VStack(spacing: 12) {
            
            Image(image)
                .resizable()
                .frame(width: imgWidth, height: imgHeight)
                .clipShape(.rect(cornerRadius: 7.5))
            
            HStack {
                Text(title)
                    .font(.roboto(type: .regular, size: 13))
                    .foregroundStyle(.black)
                
                Spacer()
                
                Image(.heart)
            }
        }
    }
}

struct OtherCategoryCell: View {
    
    let image: ImageResource
    
    let imgWidth: CGFloat
    
    let imgHeight: CGFloat
    
    let title: String
    
    var body: some View {
        
        VStack(spacing: 12) {
            
            Image(image)
                .resizable()
                .frame(width: imgWidth, height: imgHeight)
                .clipShape(.rect(cornerRadius: 7.5))
            
            Text(title)
                .font(.roboto(type: .regular, size: 13))
                .foregroundStyle(.black)
        }
    }
}
