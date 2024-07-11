//
//  UserProfile.swift
//  VYBE
//
//  Created by Hamza Hashmi on 12/07/2024.
//

import Foundation

struct UserProfile: Identifiable, Codable {
    var id = UUID().uuidString
    var userName: String = ""
    var fullName: String = ""
    var phone: String    = ""
    var email: String    = ""
    var dob: String      = ""
    var cityAndCountry: String = ""
}
