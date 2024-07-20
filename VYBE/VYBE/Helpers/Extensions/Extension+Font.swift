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
        return Font.custom("Rubik-\(type.rawValue)", size: size)
        /*
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
         */
    }
    
    static func roboto(type: FontType, size: CGFloat) -> Font {
        return Font.custom("Roboto-\(type.rawValue)", size: size)
        /*
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
        */
    }
}

extension UIFont {
    
    class func roboto(type: FontType, size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-\(type.rawValue)", size: size)!
        /*
        switch type {
        case .bold:
            return UIFont(name: "Roboto-Bold", size: size)!
        case .medium:
            return UIFont(name: "Roboto-Medium", size: size)!
        case .regular:
            return UIFont(name: "Roboto-Regular", size: size)!
        case .semiBold:
            return UIFont(name: "Roboto-Black", size: size)!
        }
         */
    }
}

enum FontType: String {
    case regular = "Regular"
    case medium = "Medium"
    case bold = "Bold"
    case italic = "Italic"
}
