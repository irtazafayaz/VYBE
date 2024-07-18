//
//  CircleDashedBorder.swift
//  VYBE
//
//  Created by Hamza Hashmi on 18/07/2024.
//

import Foundation
import SwiftUI

struct CircleDashedBorder: View {
    
    let numberOfArcs: Int
    let gapWidth: CGFloat = 0.05
    
    var body: some View {
        ForEach(0..<numberOfArcs, id: \.self) { index in
            Circle()
                .trim(
                    from: CGFloat(index) / CGFloat(numberOfArcs) + gapWidth / 2,
                    to: CGFloat(index + 1) / CGFloat(numberOfArcs) - gapWidth/2)
                .stroke(Color.buttonBlue, lineWidth: 2)
        }
    }
}
