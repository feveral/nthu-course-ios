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

class Course: NSObject {
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
    
    override var description: String {
        return "\(super.description) courseId:\(courseId) chineseName:\(chineseName) englishName:\(englishName) credits:\(credits) peopleLimit:\(peopleLimit) newStudentReserved: \(newStudentReserved) liberalTarget:\(liberalTarget) liberalType:\(liberalType) language:\(language) remarks:\(remarks) stopOpeningNotes:\(stopOpeningNotes) teacher:\(teacher) blockStatement:\(blockStatement) courseLimitStatement:\(courseLimitStatement) firstSecondSpecialties:\(firstSecondSpecialties) creditCourseCorrespondence:\(creditCourseCorrespondence) cannotSignedStatement:\(cannotSignedStatement) compulsoryStatement:\(compulsoryStatement) roomTime: \(roomTime.description)"
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
    
    static func dbRowToCourse(courseRow: [Binding?], courseRoomTimeRows: [[Binding?]]) -> Course {
        let roomTime = CourseRoomTime()
        for r in courseRoomTimeRows {
            roomTime.add(r[1]! as! String, r[2]! as! String)
        }
        return Course(
            courseId: courseRow[0]! as! String,
            chineseName: courseRow[1]! as! String,
            englishName: courseRow[2]! as! String,
            credits: Int(courseRow[3]! as! Int64),
            peopleLimit: courseRow[4]! as! String,
            newStudentReserved: Int(courseRow[5]! as! Int64),
            liberalTarget: courseRow[6]! as! String,
            liberalType: courseRow[7]! as! String,
            language: courseRow[8]! as! String,
            remarks: courseRow[9]! as! String,
            stopOpeningNotes: courseRow[10]! as! String,
            roomTime: roomTime,
            teacher: courseRow[11]! as! String,
            blockStatement: courseRow[12]! as! String,
            courseLimitStatement: courseRow[13]! as! String,
            firstSecondSpecialties: courseRow[14]! as! String,
            creditCourseCorrespondence: courseRow[15]! as! String,
            cannotSignedStatement: courseRow[16]! as! String,
            compulsoryStatement: courseRow[17]! as! String
        )
    }
    
    static func save(course: Course) {
        do {
            let db: Connection = CourseDatabase.getDatabaseConnection()!
            let insertCourseSQL = """
            INSERT INTO \(Config.Text.COURSE) VALUES(
            '\(course.courseId)', '\(course.chineseName)', '\(course.englishName)',
            '\(course.credits)', '\(course.peopleLimit)', '\(course.newStudentReserved)',
            '\(course.liberalTarget)', '\(course.liberalType)', '\(course.language)',
            '\(course.remarks)', '\(course.stopOpeningNotes)', '\(course.teacher)',
            '\(course.blockStatement)', '\(course.courseLimitStatement)', '\(course.firstSecondSpecialties)',
            '\(course.creditCourseCorrespondence)', '\(course.cannotSignedStatement)', '\(course.compulsoryStatement)')
            """
            try db.execute(insertCourseSQL)
            for (room, timeSlotList) in course.roomTime.get() {
                for timeSlot in timeSlotList {
                    try db.execute("""
                        INSERT INTO \(Config.Text.COURSE_ROOM_TIME) VALUES(
                        '\(course.courseId)', '\(room)', '\(timeSlot.toString())')
                        """
                    )
                }
            }
        } catch {
            print(error)
        }
    }
    
    static func saveMany(_ courses: [Course]) {
        for course in courses {
            Course.save(course: course)
        }
    }
    
    static func deleteAll() {
        do {
            let db = CourseDatabase.getDatabaseConnection()
            try db?.execute("DELETE FROM \(Config.Text.COURSE)")
            try db?.execute("DELETE FROM \(Config.Text.COURSE_ROOM_TIME)")
        } catch {
            print(error)
        }
    }
    
    static func isAnyCourseExist() -> Bool {
        do {
            let db: Connection = CourseDatabase.getDatabaseConnection()!
            for _ in try db.prepare("SELECT * FROM \(Config.Text.COURSE)") {
                return true
            }
        } catch {
            print(error)
        }
        return false
    }
    
    static func findAllCourse() -> [Course] {
        do {
            var courses: [Course] = []
            let db: Connection = CourseDatabase.getDatabaseConnection()!
            let courseSQL = "SELECT * from \(Config.Text.COURSE)"
            for row in try db.prepare(courseSQL) {
                let roomTimeSQL = "SELECT * FROM \(Config.Text.COURSE_ROOM_TIME) WHERE courseId='\(row[0]! as! String)'"
                var roomTimeRows: [[Binding?]] = []
                for rtr in try db.prepare(roomTimeSQL) {
                    roomTimeRows.append(rtr)
                }
                courses.append(Course.dbRowToCourse(courseRow: row, courseRoomTimeRows: roomTimeRows))
            }
            return courses
        } catch {
            print(error)
        }
        return []
    }
}
