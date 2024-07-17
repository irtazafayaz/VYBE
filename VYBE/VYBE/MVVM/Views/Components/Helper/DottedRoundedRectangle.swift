//
//  DottedRoundedRectangle.swift
//  VYBE
//
//  Created by Macbook 5 on 7/17/24.
//

import SwiftUI

struct DottedRoundedRectangle: View {
    
    enum BorderPosition {
        case inset, centered
    }
    
    let evenNumberOfDashes: Int
    let color: Color
    let strokeWidth: Double
    let radius: Double
    let borderPosition: BorderPosition
    
    private var insetDistance: Double {
            switch borderPosition {
            case .centered:
                return 0
            case .inset:
                return strokeWidth / 2
            }
        }
    
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            
            // an odd number of dashes is bad -- results in back-to-back dashes at wrap around point
            let _evenNumDashes = evenNumberOfDashes + (evenNumberOfDashes % 2)
            
            let horizontalSideLength = (w - (2 * insetDistance)) - (2 * (radius - insetDistance))
            let verticalSideLength = (h - (2 * insetDistance)) - (2 * (radius - insetDistance))
            let cornerLength = Double.pi/2 * (radius - insetDistance)
           
            let perimeter = (horizontalSideLength * 2) + (verticalSideLength * 2) + (cornerLength * 4)
           
            let dashLength:Double = perimeter/Double(_evenNumDashes)
                    
            switch borderPosition {
            case .inset:
                RoundedRectangle(cornerRadius: radius)
//                    .fill(Material.ultraThin)
                    .strokeBorder(style: StrokeStyle(lineWidth: strokeWidth, dash: [dashLength]))
                    .foregroundColor(color)
            case .centered:
                RoundedRectangle(cornerRadius: radius)
//                    .fill(Material.ultraThin)
                    .stroke(color, style: StrokeStyle(lineWidth: strokeWidth, dash: [dashLength]))
            }
           
        }
    }
    
}
