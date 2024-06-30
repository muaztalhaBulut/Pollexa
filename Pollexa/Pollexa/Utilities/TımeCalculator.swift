//
//  Date+Ext.swift
//  Pollexa
//
//  Created by Eda Bulut on 8.06.2024.
//

import Foundation

enum CaseStyle {
    case uppercase
    case lowercase
    case original
}

func timeAgoSinceDate(_ date: Date, currentDate: Date = Date(), numericDates: Bool = false, caseStyle: CaseStyle = .original) -> String {
    let calendar = Calendar.current
    let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
    let components = calendar.dateComponents(unitFlags, from: date, to: currentDate)
    
    var result: String
    
    if let year = components.year, year >= 2 {
        result = "\(year) years ago"
    } else if let year = components.year, year >= 1 {
        result = numericDates ? "1 year ago" : "last year"
    } else if let month = components.month, month >= 2 {
        result = "\(month) months ago"
    } else if let month = components.month, month >= 1 {
        result = numericDates ? "1 month ago" : "last month"
    } else if let week = components.weekOfYear, week >= 2 {
        result = "\(week) weeks ago"
    } else if let week = components.weekOfYear, week >= 1 {
        result = numericDates ? "1 week ago" : "last week"
    } else if let day = components.day, day >= 2 {
        result = "\(day) days ago"
    } else if let day = components.day, day >= 1 {
        result = numericDates ? "1 day ago" : "yesterday"
    } else if let hour = components.hour, hour >= 2 {
        result = "\(hour) hours ago"
    } else if let hour = components.hour, hour >= 1 {
        result = numericDates ? "1 hour ago" : "an hour ago"
    } else if let minute = components.minute, minute >= 2 {
        result = "\(minute) minutes ago"
    } else if let minute = components.minute, minute >= 1 {
        result = numericDates ? "1 minute ago" : "a minute ago"
    } else if let second = components.second, second >= 3 {
        result = "\(second) seconds ago"
    } else {
        result = "just now"
    }
    
    switch caseStyle {
    case .uppercase:
        return result.uppercased()
    case .lowercase:
        return result.lowercased()
    case .original:
        return result
    }
}
