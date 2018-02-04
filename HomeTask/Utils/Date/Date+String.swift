//
//  Date+String.swift
//  HomeTask
//
//  Created by Zhenya Koval on 2/4/18.
//  Copyright © 2018 Zhenya Koval. All rights reserved.
//

import Foundation

extension Date {
    
    var hoursAgoString: String {
        guard Date() > self else {
            return ""
        }
        
        var result = ""
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: self, to: Date())
        
        if let hours = components.hour {
            if hours >= 2 {
                result = "\(hours) hours ago"
            } else {
                result = "An hour ago"
            }
        } else if let minutes = components.minute {
            if minutes >= 2 {
                result = "\(minutes) minutes ago"
            } else {
                result = "A minute ago"
            }
        } else {
            result = "Just now"
        }
        
        return result
    }
    
}

