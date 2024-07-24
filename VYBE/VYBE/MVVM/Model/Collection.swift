//
//  Collection.swift
//  VYBE
//
//  Created by Irtaza Fiaz on 19/07/2024.
//

import Foundation

struct ProfileCollection: Identifiable {
    let id = UUID().uuidString
    let img: ImageResource
    let title: String
}
