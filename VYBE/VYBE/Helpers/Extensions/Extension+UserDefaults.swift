//
//  Extension+UserDefaults.swift
//  VYBE
//
//  Created by Hamza Hashmi on 12/07/2024.
//

import Foundation

extension UserDefaults {
    
    var email: String? {
        get {
            return UserDefaults.standard.string(forKey: "email")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "email")
        }
    }
    
    var password: String? {
        get {
            return UserDefaults.standard.string(forKey: "password")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "password")
        }
    }
}
