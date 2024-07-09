//
//  SplashView.swift
//  VYBE
//
//  Created by Hamza Hashmi on 09/07/2024.
//

import Foundation
import SwiftUI

struct SplashView: View {
    
    var body: some View {
        Image(.logoText)
            .resizable()
            .frame(width: .width, height: .width)
            .aspectRatio(contentMode: .fit)
            .padding()
    }
}
