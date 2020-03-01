//
//  DurationStringHelper.swift
//  ScottishPowerTest
//
//  Created by Stephen on 01/03/2020.
//  Copyright © 2020 Stephen. All rights reserved.
//

import Foundation

class DurationStringHelper {
    
    //this whole function feels a bit clunky, but in the interest of time for the test I'll unit test a little and leave it.
    class func durationString(milliseconds: Int) -> String {
        
        let timeInterval = TimeInterval(milliseconds / 1000)
        var timeString = ""
        let hour = Int((timeInterval / 3600).truncatingRemainder(dividingBy: 3600))
        
        if hour > 0 {
            timeString += "\(hour)"
            timeString += " hour"
            //otherwise we would have a space at the beginning if we put the space before minutes.
            timeString += hour > 1 ? "s " : " "
        }
        
        let minute = Int((timeInterval / 60).truncatingRemainder(dividingBy: 60))
        timeString += "\(minute)"
        timeString += (minute > 1 || minute == 0) ? " minutes" : " minute"
        
        let seconds = Int((timeInterval).truncatingRemainder(dividingBy: 60))
        timeString += " \(seconds)"
        timeString += (seconds > 1 || seconds == 0) ? " seconds" : " second"
        
        return timeString
    }
}

