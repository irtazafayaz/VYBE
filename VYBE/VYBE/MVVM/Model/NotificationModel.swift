//
//  NotificationModel.swift
//  VYBE
//
//  Created by Macbook 5 on 7/19/24.
//

import Foundation

struct NotificationGroup {
    let date: Date
    var notifications: [NotificationModel]
}

struct NotificationModel:Identifiable {
    
    let id = UUID().uuidString
    let title:String
    let content:String
    let date:Date
    let image:String
    
    static func all() -> [NotificationModel] {
        let date = Date()
        let pday = Calendar.current.date(byAdding: .day, value: -1, to: date)!
        return [NotificationModel(title: "Dennis Nedry", content: "Like ipsum dolor sit amet, cons...", date: date.addingTimeInterval(-1000), image: ""),
                NotificationModel(title: "Dennis Nedry", content: "Comment Lorem ipsum dolor sit amet, cons...", date: date.addingTimeInterval(-2000), image: ""),
                NotificationModel(title: "Dennis Nedry", content: "Like ipsum dolor sit amet, cons...", date: date.addingTimeInterval(-3000), image: ""),
                NotificationModel(title: "Dennis Nedry", content: "@Mention Lorem ipsum dolor sit amet, cons...", date: pday.addingTimeInterval(-1000), image: ""),
                NotificationModel(title: "Dennis Nedry", content: "Add Story ipsum dolor sit amet, cons...", date: pday.addingTimeInterval(-6000), image: "")]
    }
}
