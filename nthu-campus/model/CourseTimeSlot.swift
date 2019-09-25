//
//  CourseTimeSlot.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/9/24.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import Foundation


enum DayOfWeek {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case other
}

enum CoursePeriod {
    case period1
    case period2
    case period3
    case period4
    case period5
    case period6
    case period7
    case period8
    case period9
    case perioda
    case periodb
    case periodc
    case other
}

class CourseTimeSlot {

    var dayOfWeek: DayOfWeek = .other
    var coursePeriod: CoursePeriod = .other
    
    init(_ dayOfWeek: DayOfWeek, _ coursePeriod: CoursePeriod) {
        self.dayOfWeek = dayOfWeek
        self.coursePeriod = coursePeriod
    }
    
    public func getTimeSlots() -> (DayOfWeek, CoursePeriod) {
        return (dayOfWeek, coursePeriod)
    }
    
    public func toString() -> String {
        return CourseTimeSlot.dayOfWeekToString(dayOfWeek) + CourseTimeSlot.coursePeriodToString(coursePeriod)
    }
    
    public func equal(_ courseTimeSlot: CourseTimeSlot) -> Bool {
        if (courseTimeSlot.dayOfWeek == self.dayOfWeek
            && courseTimeSlot.coursePeriod == self.coursePeriod) {
            return true
        }
        return false
    }
    
    static func makeByString(_ dayOfWeekStr: String, _ periodStr: String) -> CourseTimeSlot {
        return CourseTimeSlot(CourseTimeSlot.toDayOfWeek(dayOfWeekStr), CourseTimeSlot.toCoursePeriod(periodStr))
    }
    
    static func dayOfWeekToString(_ dayOfWeek: DayOfWeek) -> String {
        if (dayOfWeek == .monday) { return "M" }
        else if (dayOfWeek == .tuesday) { return "T" }
        else if (dayOfWeek == .wednesday) { return "W" }
        else if (dayOfWeek == .thursday) { return "R" }
        else if (dayOfWeek == .friday) { return "F" }
        else if (dayOfWeek == .saturday) { return "S" }
        else { return "" }
    }
    
    static func coursePeriodToString(_ coursePeriod: CoursePeriod) -> String {
        if (coursePeriod == .period1) { return "1" }
        else if (coursePeriod == .period2) { return "2" }
        else if (coursePeriod == .period3) { return "3" }
        else if (coursePeriod == .period4) { return "4" }
        else if (coursePeriod == .period5) { return "5" }
        else if (coursePeriod == .period6) { return "6" }
        else if (coursePeriod == .period7) { return "7" }
        else if (coursePeriod == .period8) { return "8" }
        else if (coursePeriod == .period9) { return "9" }
        else if (coursePeriod == .perioda) { return "a" }
        else if (coursePeriod == .periodb) { return "b" }
        else if (coursePeriod == .periodc) { return "c" }
        else { return "" }
    }
    
    static func toDayOfWeek(_ str: String) -> DayOfWeek {
        if (str == "M") { return .monday }
        else if (str == "T") { return .tuesday }
        else if (str == "W") { return .wednesday }
        else if (str == "R") { return .thursday }
        else if (str == "F") { return .friday }
        else if (str == "S") { return .saturday }
        else { return .other }
    }
    
    static func toCoursePeriod(_ str: String) -> CoursePeriod {
        if (str == "1") { return .period1 }
        else if (str == "2") { return .period2 }
        else if (str == "3") { return .period3 }
        else if (str == "4") { return .period4 }
        else if (str == "5") { return .period5 }
        else if (str == "6") { return .period6 }
        else if (str == "7") { return .period7 }
        else if (str == "8") { return .period8 }
        else if (str == "9") { return .period9 }
        else if (str == "a") { return .perioda }
        else if (str == "b") { return .periodb }
        else if (str == "c") { return .periodc }
        else { return .other }
    }
    
    static func isWeekOfDayLegal(_ w: String) -> Bool {
        if (w == "M" || w == "T" || w == "W" || w == "R" || w == "F" || w == "S") {
            return true
        }
        return false
    }
    
    static func isPeriodLegal(_ p: String) -> Bool {
        if (p == "1" || p == "2" || p == "3" || p == "4" || p == "5" || p == "6"
            || p == "7" || p == "8" || p == "9" || p == "a" || p == "b" || p == "c") {
            return true
        }
        return false
    }
}
