//
//  SplashView.swift
//  VYBE
//
//  Created by Irtaza Fiaz on 09/07/2024.
//

import Foundation
import SwiftUI

struct SplashView: View {
    
    private let width: CGFloat = .width - 90
    
    var body: some View {
        Image(.logoText)
            .resizable()
            .frame(width: width, height: width)
            .aspectRatio(contentMode: .fit)
            .padding()
    }
}
