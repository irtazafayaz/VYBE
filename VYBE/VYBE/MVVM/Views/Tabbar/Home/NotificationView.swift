//
//  NotificationView.swift
//  VYBE
//
//  Created by Macbook 5 on 7/19/24.
//

import SwiftUI

struct NotificationView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var vm:HomeViewModel
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    ForEach(vm.groupedNotifications,id:\.date) { notificationGroup in
                        HStack {
                            Text(headerTitle(for: notificationGroup.date))
                                .font(.roboto(type: .bold, size: 13))
                                .foregroundStyle(.textLightGray.opacity(0.9))
                            Rectangle().foregroundStyle(.textLightGray.opacity(0.2)).frame(height: 1)
                        }
                        ForEach(notificationGroup.notifications) { notification in
                            NotificationRow(notification: notification)
                                .padding(.vertical,10)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                ChevronBackButtonAction(action: {
                    dismiss()
                }, title: "Notifications")
            }
        }
    }
    
    
    func NotificationRow(notification:NotificationModel) -> some View {
        return HStack(alignment: .top) {
            Image(notification.image)
                .resizable()
                .scaledToFill()
                .clipShape(.circle)
                .frame(width: 45,height: 45)
                .shadow(radius: 3)
                .background {
                    ZStack {
                        Circle()
                            .fill(.textLightGray)
                        ProgressView()
                    }
                }
            VStack(alignment: .leading) {
                HStack {
                    Text(notification.title)
                        .font(.roboto(type: .bold, size: 15))
                        .foregroundStyle(.textDark)
                    Spacer()
                    Text("11:42 PM")
                        .font(.roboto(type: .bold, size: 15))
                        .foregroundStyle(.lightBackground.opacity(0.1))
                }
                HStack(alignment: .top,spacing: 2) {
                    if let bold = isBoldContent(text: notification.content) {
                        Text(bold)
                            .font(.roboto(type: .bold, size: 14))
                            .foregroundColor(.textDark)
                        +
                        Text(trimmedString(text: notification.content))
                            .font(.roboto(type: .regular, size: 14))
                            .foregroundColor(.textDark)
                    } else {
                        Text(notification.content)
                            .font(.roboto(type: .regular, size: 14))
                            .foregroundStyle(.textDark)
                    }
                }
            }
        }
    }
    
    // Helper function to format header titles
       private func headerTitle(for date: Date) -> String {
           let dateFormatter = DateFormatter()
           if Calendar.current.isDateInToday(date) {
               return "Today"
           } else if Calendar.current.isDateInYesterday(date) {
               return "Yesterday"
           } else {
               dateFormatter.dateFormat = "MMM d"
           }
           return dateFormatter.string(from: date)
       }
    
    
    private func isBoldContent(text:String) -> String? {
        var f:String? = nil
        let all = text.components(separatedBy: " ")
        if let first = all.first {
            if first == "Like" {
                f = first
            } else
            if first == "Comment" {
                f = first
            } else
            if first.first == "@" {
                f = first
            }
        }
        if all.count > 1 {
            if all[0] == "Add" && all[1] == "Story" {
                f = all[0] + " " + all[1]
            }
        }
        return f
    }
    
    private func trimmedString(text:String) -> String {
        var f:String? = nil
        let all = text.components(separatedBy: " ")
        if let first = all.first {
            if first == "Like" {
                f = first
            } else
            if first == "Comment" {
                f = first
            } else
            if first.first == "@" {
                f = first
            }
        }
        if all.count > 1 {
            if all[0] == "Add" && all[1] == "Story" {
                f = all[0] + " " + all[1]
            }
        }
        if let fx = f {
            let count = fx.count
            var txt = text
            txt.removeFirst(count)
            return txt
        } else {
            return text
        }
    }
    
}
