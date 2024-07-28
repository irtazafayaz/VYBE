//
//  UserProfile.swift
//  VYBE
//
//  Created by Irtaza Fiaz on 12/07/2024.
//

import Foundation

struct UserProfile: Identifiable, Codable {
    var id: String
    var userName: String = ""
    var address = ""
    var bio: String = ""
    var fullName: String = ""
    var phone: String    = ""
    var email: String    = ""
    var dob: String      = ""
    var cityAndCountry: String = ""
    var profileImageUrl: String?
}
