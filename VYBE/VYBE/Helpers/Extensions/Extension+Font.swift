//
//  Extension+Font.swift
//  VYBE
//
//  Created by Hamza Hashmi on 10/07/2024.
//

import Foundation
import SwiftUI

extension Font {
    static func rubik(type: FontType, size: CGFloat) -> Font {
        switch type {
        case .bold:
            return Font.custom("Rubik-Bold", size: size)
        case .medium:
            return Font.custom("Rubik-Medium", size: size)
        case .regular:
            return Font.custom("Rubik-Regular", size: size)
        case .semiBold:
            return Font.custom("Rubik-SemiBold", size: size)
        }
    }
    
    static func roboto(type: FontType, size: CGFloat) -> Font {
        switch type {
        case .bold:
            return Font.custom("Roboto-Bold", size: size)
        case .medium:
            return Font.custom("Roboto-Medium", size: size)
        case .regular:
            return Font.custom("Roboto-Regular", size: size)
        case .semiBold:
            return Font.custom("Roboto-Black", size: size)
        }
    }
}

enum FontType {
    case regular
    case medium
    case semiBold
    case bold
}
