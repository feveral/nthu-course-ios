//
//  CourseRoomTime.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/9/25.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import Foundation

class CourseRoomTime: NSObject {
    
    var roomTime: [String: [CourseTimeSlot]] = [:]
    
    // format example: room->DELTA台達B05 timeSlots->T3T4R3R4
    func add(_ room: String, _ timeSlots: String) {
        var t = timeSlots
        for _ in 1...t.count/2 {
            let dStr = String(t.removeFirst())
            let pStr = String(t.removeFirst())
            if var timeSlotList = roomTime[room] {
                timeSlotList.append(CourseTimeSlot.makeByString(dStr, pStr))
                roomTime[room] = timeSlotList
            } else {
                var tsl: [CourseTimeSlot] = []
                tsl.append(CourseTimeSlot.makeByString(dStr, pStr))
                roomTime[room] = tsl
            }
        }
    }
    
    func get() -> [String:[CourseTimeSlot]] {
        return roomTime
    }
    
    override var description: String {
        var str = ""
        for (room, ctsList) in roomTime {
            str += "room:\(room) ["
            for cts in ctsList {
                str += "timeSlot: \(cts.description), "
            }
            str += "]"
        }
        return str
    }
    
}
