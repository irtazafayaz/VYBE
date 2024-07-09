////
////  Router.swift
////  VYBE
////
////  Created by Hamza Hashmi on 10/07/2024.
////
//
//import Foundation
//import SwiftUI
//
//class Router: ObservableObject {
//    
//    @Published var path = NavigationPath()
//    
//    func push<Content: View>(view: Content) {
//        path.append()
//        path.append(view)
//    }
//    
//    func pop() {
//        path.removeLast()
//    }
//    
//    func popToRoot() {
//        path.removeLast(path.count)
//    }
//}
