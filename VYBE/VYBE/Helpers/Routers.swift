//
//  Router.swift
//  VYBE
//
//  Created by Irtaza Fiaz on 10/07/2024.
//

import Foundation
import SwiftUI

class OnboardingRouter: ObservableObject {
    
    @Published var path = NavigationPath()
    
    func push(path: OnboardingPath) {
        self.path.append(path)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
