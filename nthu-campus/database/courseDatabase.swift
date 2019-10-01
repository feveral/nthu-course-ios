//
//  courseDatabase.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/9/23.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import Foundation
import SQLite

class CourseDatabase {
    
    static var databaseURL: URL?
    static var db: Connection?
    
    static func getDatabaseConnection() -> Connection? {
        do {
            if let f = databaseURL {
                return try Connection(f.path)
            } else {
                openDatabase()
                return try Connection(databaseURL!.path)
            }
        } catch {
            print("course database connection error: \(error)")
            return nil
        }
    }
    
    static func openDatabase() -> Void {
        let fileManager = FileManager.default
        guard let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        databaseURL = documentsUrl.appendingPathComponent("\(Config.Text.COURSE_DB_FILE_NAME).db")
        if !fileManager.fileExists(atPath: databaseURL!.path) {
            print("Course DB does not exist in documents folder")
            do {
                db = try Connection(databaseURL!.path)
                createAllTable()
            } catch {
                print("CourseDB openDatabase Connection Fail")
            }
        }
    }
    
    static func createTable(sql: String, tableName: String) {
        do {
            try db?.execute(sql)
        } catch {
            print("Create Table \(tableName)")
        }
    }
    
    static func createAllTable() {
        let createCourseSQL =
        """
            CREATE TABLE \(Config.Text.COURSE) (
                courseId TEXT NOT NULL PRIMARY KEY,
                chineseName TEXT NOT NULL,
                englishName TEXT NOT NULL,
                credits INTEGER NOT NULL,
                peopleLimit TEXT NOT NULL,
                newStudentReserved INTEGER NOT NULL,
                liberalTarget TEXT NOT NULL,
                liberalType TEXT NOT NULL,
                language TEXT NOT NULL,
                remarks TEXT NOT NULL,
                stopOpeningNotes TEXT NOT NULL,
                teacher TEXT NOT NULL,
                blockStatement TEXT NOT NULL,
                courseLimitStatement TEXT NOT NULL,
                firstSecondSpecialties TEXT NOT NULL,
                creditCourseCorrespondence TEXT NOT NULL,
                cannotSignedStatement TEXT NOT NULL,
                compulsoryStatement TEXT NOT NULL,
                complete INTEGER NOT NULL
            );
        """
        let createCourseRoomTimeSQL =
        """
            CREATE TABLE \(Config.Text.COURSE_ROOM_TIME) (
                courseId TEXT NOT NULL,
                room TEXT NOT NULL,
                timeSlot TEXT NOT NULL
            );
        """
        
        let createSettingSQL =
        """
            CREATE TABLE \(Config.Text.SETTING) (
                key TEXT NOT NULL PRIMARY KEY,
                value TEXT NOT NULL
            );
        """
        CourseDatabase.createTable(sql: createCourseSQL, tableName: Config.Text.COURSE)
        CourseDatabase.createTable(sql: createCourseRoomTimeSQL, tableName: Config.Text.COURSE_ROOM_TIME)
        CourseDatabase.createTable(sql: createSettingSQL, tableName: Config.Text.SETTING)
    }
    
}
