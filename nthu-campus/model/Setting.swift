//
//  Setting.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/9/27.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import Foundation

class Setting {
    
    static func find(_ key: String) -> String {
        do {
            let db = CourseDatabase.getDatabaseConnection()!
            for row in try db.prepare("SELECT * FROM \(Config.Text.SETTING) WHERE key='\(key)'") {
                return (row[1]! as! String)
            }
        } catch {
            print(error)
        }
        return ""
    }
    
    static func set(_ key: String, _ value: String) {
        do {
            let db = CourseDatabase.getDatabaseConnection()!
            
            if (Setting.isSettingExist(key)) {
                let sql = "UPDATE \(Config.Text.SETTING) SET value='\(value)' WHERE key='\(key)' "
                try db.execute(sql)
            } else {
                let sql = "INSERT INTO \(Config.Text.SETTING) VALUES ('\(key)', '\(value)')"
                try db.execute(sql)
            }
        } catch {
            print(error)
        }
    }
    
    static func isSettingExist(_ setting: String) -> Bool {
        do {
            let db = CourseDatabase.getDatabaseConnection()!
            let sql = "SELECT * FROM \(Config.Text.SETTING) WHERE key='\(setting)'"
            for _ in try db.prepare(sql) {
                return true
            }
        } catch {
            print(error)
        }
        return false
    }
}
