//
//  DateProcessor.swift
//  HitList
//
//  Created by Joshua Book on 7/3/15.
//  Copyright (c) 2015 Boovius Projects. All rights reserved.
//

import Foundation

class DateProcessor {
    
    class func beginningOfWeek() -> NSDate? {
        let cal = NSCalendar.currentCalendar()
        
        let components = NSDateComponents()
        var beginningOfWeek: NSDate?
        if let date = cal.dateByAddingComponents(components, toDate: NSDate(), options: NSCalendarOptions(0)) {
            var weekDuration = NSTimeInterval()
            if cal.rangeOfUnit(.CalendarUnitWeekOfYear, startDate: &beginningOfWeek, interval: &weekDuration, forDate: date) {
                let endOfWeek = beginningOfWeek?.dateByAddingTimeInterval(weekDuration)
            }
        }
        return beginningOfWeek
    }
    
    class func firstDateGreaterThanSecond(first: NSDate, second: NSDate) -> Bool {
        return first.compare(second) == NSComparisonResult.OrderedDescending
    }
    
    class func inThisWeek(date: NSDate) -> Bool {
        if let beginning = beginningOfWeek() {
            return firstDateGreaterThanSecond(date, second: beginning)
        } else {
            return false
        }
    }
}