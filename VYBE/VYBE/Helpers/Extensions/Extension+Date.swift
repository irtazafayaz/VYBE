//
//  Extension+Date.swift
//  VYBE
//
//  Created by Irtaza Fiaz on 17/07/2024.
//

import Foundation

extension Double {
    
    /// return in today, yesterday, 1 day ago, 1 week ago, 1 month ago etc
    func getTimeAgo() -> String {
        
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        
        return date.getTimeAgo()
        /*
        let calendar = Calendar.current
        
        let yearsCount = calendar.dateComponents([.year], from: date, to: .now).year!
        
        let monthCount = calendar.dateComponents([.month], from: date, to: .now).month!
        
        let weeksCount = calendar.dateComponents([.weekOfMonth], from: date, to: .now).weekOfMonth!
        
        let daysCount = calendar.dateComponents([.day], from: date, to: .now).day!
        
        let hoursCount = calendar.dateComponents([.hour], from: date, to: .now).hour!
        
        let minutesCount = calendar.dateComponents([.minute], from: date, to: .now).minute!
        
        let secondsCount = calendar.dateComponents([.second], from: date, to: .now).second!
        
        if yearsCount > 0 {
            return "\(yearsCount) \(yearsCount > 1 ? "years" : "year") ago"
        }
        else if monthCount > 0 {
            return "\(monthCount) \(monthCount > 1 ? "months" : "month") ago"
        }
        else if weeksCount > 0 {
            return "\(weeksCount) \(weeksCount > 1 ? "weeks" : "week") ago"
        }
        else if daysCount > 0 {
            return "\(daysCount) \(daysCount > 1 ? "days" : "day") ago"
        }
        else if hoursCount > 0 {
            return "\(hoursCount) \(hoursCount > 1 ? "hours" : "hour") ago"
        }
        else if minutesCount > 0 {
            return "\(minutesCount) \(minutesCount > 1 ? "minute" : "minute") ago"
        }
        else {
            return "\(secondsCount) \(secondsCount > 1 ? "seconds" : "second") ago"
        }
        */
    }
}

extension Date {
    
    /// return in today, yesterday, 1 day ago, 1 week ago, 1 month ago etc
    func getTimeAgo() -> String {
        
        let date = self
        
        let calendar = Calendar.current
        
        let yearsCount = calendar.dateComponents([.year], from: date, to: .now).year!
        
        let monthCount = calendar.dateComponents([.month], from: date, to: .now).month!
        
        let weeksCount = calendar.dateComponents([.weekOfMonth], from: date, to: .now).weekOfMonth!
        
        let daysCount = calendar.dateComponents([.day], from: date, to: .now).day!
        
        let hoursCount = calendar.dateComponents([.hour], from: date, to: .now).hour!
        
        let minutesCount = calendar.dateComponents([.minute], from: date, to: .now).minute!
        
        let secondsCount = calendar.dateComponents([.second], from: date, to: .now).second!
        
        if yearsCount > 0 {
            return "\(yearsCount) \(yearsCount > 1 ? "years" : "year") ago"
        }
        else if monthCount > 0 {
            return "\(monthCount) \(monthCount > 1 ? "months" : "month") ago"
        }
        else if weeksCount > 0 {
            return "\(weeksCount) \(weeksCount > 1 ? "weeks" : "week") ago"
        }
        else if daysCount > 0 {
            return "\(daysCount) \(daysCount > 1 ? "days" : "day") ago"
        }
        else if hoursCount > 0 {
            return "\(hoursCount) \(hoursCount > 1 ? "hours" : "hour") ago"
        }
        else if minutesCount > 0 {
            return "\(minutesCount) \(minutesCount > 1 ? "minute" : "minute") ago"
        }
        else {
            return "\(secondsCount) \(secondsCount > 1 ? "seconds" : "second") ago"
        }
    }
}
