//
//  Date+.swift
//
//
//  Created by Ahmed Yamany on 22/04/2024.
//

import Foundation

extension Date {
    func toCurrentTimeZone() -> Date {
        let localTimeZone = TimeZone.current
        let secondsOffset = TimeInterval(localTimeZone.secondsFromGMT(for: self))
        let localizedDate = self.addingTimeInterval(secondsOffset)
        return localizedDate
    }
}

extension Date {
    func dateString(style dateStyle: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        return formatter.string(from: self)
    }
    
    func timeString(style timeStyle: DateFormatter.Style = .medium) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .long
        return formatter.string(from: self)
    }
    
    func fullString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss E, d MMM y"
        return formatter.string(from: self)
    }
    
    func fullDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y"
        return formatter.string(from: self)
    }
    
    func fullTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: self)
    }
}

extension Date {
    func hasSameDay(to date: Date) -> Bool {
        let calendar = Calendar.current
        let components1 = calendar.dateComponents([.year, .month, .day], from: self)
        let components2 = calendar.dateComponents([.year, .month, .day], from: date)
        
        return components1.year == components2.year &&
        components1.month == components2.month &&
        components1.day == components2.day
    }
    
    func isAtPast() -> Bool {
        self < Date.now && !self.hasSameDay(to: Date.now)
    }
    
    // swiftlint: disable all
    func difference(from date: Date) -> (days: Int, hours: Int, minutes: Int, seconds: Int) {
        // swiftlint: enable all
        let calendar = Calendar.current
        
        let difference = calendar.dateComponents([.day, .hour, .minute, .second], from: self, to: date)
        
        let days = difference.day ?? 0
        let hours = difference.hour ?? 0
        let minutes = difference.minute ?? 0
        let seconds = difference.second ?? 0
        
        return (days, hours, minutes, seconds)
    }
}
