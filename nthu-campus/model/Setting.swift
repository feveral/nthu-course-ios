//
//  Setting.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/9/27.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import Foundation

class Setting {
    
    static func find(_ key: String) -> String? {
        do {
            let db = CourseDatabase.getDatabaseConnection()!
            for row in try db.prepare("SELECT * FROM \(Config.Text.SETTING) WHERE key='\(key)'") {
                return (row[1]! as! String)
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    static func setIlmsCookie(_ cookie: String) {
        do {
            let db = CourseDatabase.getDatabaseConnection()!
            
            if (Setting.isSettingExist(Config.Text.SETTING_ILMS_COOKIE)) {
                let sql = "UPDATE \(Config.Text.SETTING) SET value='\(cookie)' WHERE key='\(Config.Text.SETTING_ILMS_COOKIE)' "
                try db.execute(sql)
            } else {
                let sql = "INSERT INTO \(Config.Text.SETTING) VALUES ('\(Config.Text.SETTING_ILMS_COOKIE)', '\(cookie)')"
                try db.execute(sql)
            }
        } catch {
            print(error)
        }
    }
    
    static func setIlmsAccount(_ account: String) {
        do {
            let db = CourseDatabase.getDatabaseConnection()!
            
            if (Setting.isSettingExist(Config.Text.SETTING_ILMS_ACCOUNT)) {
                let sql = "UPDATE \(Config.Text.SETTING) SET value='\(account)' WHERE key='\(Config.Text.SETTING_ILMS_ACCOUNT)' "
                try db.execute(sql)
            } else {
                let sql = "INSERT INTO \(Config.Text.SETTING) VALUES ('\(Config.Text.SETTING_ILMS_ACCOUNT)', '\(account)')"
                try db.execute(sql)
            }
        } catch {
            print(error)
        }
    }
    
    static func setIlmsPassword(_ password: String) {
        do {
            let db = CourseDatabase.getDatabaseConnection()!
            
            if (Setting.isSettingExist(Config.Text.SETTING_ILMS_PASSWORD)) {
                let sql = "UPDATE \(Config.Text.SETTING) SET value='\(password)' WHERE key='\(Config.Text.SETTING_ILMS_PASSWORD)' "
                try db.execute(sql)
            } else {
                let sql = "INSERT INTO \(Config.Text.SETTING) VALUES ('\(Config.Text.SETTING_ILMS_PASSWORD)', '\(password)')"
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
