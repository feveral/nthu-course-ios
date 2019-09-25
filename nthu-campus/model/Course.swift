//
//  Course.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/9/12.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import Foundation
import SwiftyJSON
import SQLite

class Course {
    public var courseId: String
    public var chineseName: String
    public var englishName: String
    public var credits: Int
    public var peopleLimit: String
    public var newStudentReserved: Int
    public var liberalTarget: String
    public var liberalType: String
    public var language: String
    public var remarks: String
    public var stopOpeningNotes: String
    public var roomTime: CourseRoomTime
    public var teacher: String
    public var blockStatement: String
    public var courseLimitStatement: String
    public var firstSecondSpecialties: String
    public var creditCourseCorrespondence: String
    public var cannotSignedStatement: String
    public var compulsoryStatement: String
    
    init(courseId: String, chineseName: String, englishName: String, credits: Int, peopleLimit: String, newStudentReserved: Int,
         liberalTarget: String, liberalType: String, language: String, remarks: String, stopOpeningNotes: String, roomTime: CourseRoomTime,
         teacher: String, blockStatement: String, courseLimitStatement: String, firstSecondSpecialties: String,
         creditCourseCorrespondence: String, cannotSignedStatement: String, compulsoryStatement: String) {
        self.courseId = courseId
        self.chineseName = chineseName
        self.englishName = englishName
        self.credits = credits
        self.peopleLimit = peopleLimit
        self.newStudentReserved = newStudentReserved
        self.liberalTarget = liberalTarget
        self.liberalType = liberalType
        self.language = language
        self.remarks = remarks
        self.stopOpeningNotes = stopOpeningNotes
        self.roomTime = roomTime
        self.teacher = teacher
        self.blockStatement = blockStatement
        self.courseLimitStatement = courseLimitStatement
        self.firstSecondSpecialties = firstSecondSpecialties
        self.creditCourseCorrespondence = creditCourseCorrespondence
        self.cannotSignedStatement = cannotSignedStatement
        self.compulsoryStatement = compulsoryStatement
    }
    
    func isTimeSlotExist(_ timeSlot: CourseTimeSlot) -> Bool {
        for (_, timeSlotList) in self.roomTime.get() {
            for ts in timeSlotList {
                if (ts.equal(timeSlot)) {
                    return true
                }
            }
        }
        return false
    }
    
    static func jsonToCourse(_ json: JSON) -> Course {
        let roomTime = CourseRoomTime()
        for subJson in json["course"]["roomTime"].array! {
            roomTime.add(subJson["room"].string!, subJson["timeSlot"].string!)
        }
        return Course(
            courseId: json["course"]["courseId"].string!,
            chineseName: json["course"]["chineseName"].string!,
            englishName: json["course"]["englishName"].string!,
            credits: json["course"]["credits"].int!,
            peopleLimit: json["course"]["peopleLimit"].string!,
            newStudentReserved: json["course"]["newStudentReserved"].int!,
            liberalTarget: json["course"]["liberalTarget"].string!,
            liberalType: json["course"]["liberalType"].string!,
            language: json["course"]["language"].string!,
            remarks: json["course"]["remarks"].string!,
            stopOpeningNotes: json["course"]["stopOpeningNotes"].string!,
            roomTime: roomTime,
            teacher: json["course"]["teacher"].string!,
            blockStatement: json["course"]["blockStatement"].string!,
            courseLimitStatement: json["course"]["courseLimitStatement"].string!,
            firstSecondSpecialties: json["course"]["firstSecondSpecialties"].string!,
            creditCourseCorrespondence: json["course"]["creditCourseCorrespondence"].string!,
            cannotSignedStatement: json["course"]["cannotSignedStatement"].string!,
            compulsoryStatement: json["course"]["compulsoryStatement"].string!
        )
    }
    
    static func dbRowToCourse(row: [Binding?]) {
        
    }
    
    static func save(course: Course) {
        do {
            let db: Connection = CourseDatabase.getDatabaseConnection()!
            let insertCourseSQL = """
            INSERT INTO \(Config.Text.COURSE) VALUES(
            '\(course.courseId)', '\(course.chineseName)'), '\(course.englishName)'),
            '\(course.credits)'), '\(course.peopleLimit)'), '\(course.newStudentReserved)'),
            '\(course.liberalTarget)'), '\(course.liberalType)'), '\(course.language)'),
            '\(course.remarks)'), '\(course.stopOpeningNotes)'), '\(course.teacher)'),
            '\(course.blockStatement)'), '\(course.courseLimitStatement)'), '\(course.firstSecondSpecialties)'),
            '\(course.creditCourseCorrespondence)'), '\(course.cannotSignedStatement)'), '\(course.compulsoryStatement)')
            """
            try db.execute(insertCourseSQL)
            for (room, timeSlotList) in course.roomTime.get() {
                for timeSlot in timeSlotList {
                    try db.execute("""
                        INSERT INTO \(Config.Text.COURSE_ROOM_TIME) VALUES(
                        '\(course.courseId)', '\(room)', '\(timeSlot.toString())'
                        """
                    )
                }
            }
        } catch {
            print(error)
        }
    }
}
