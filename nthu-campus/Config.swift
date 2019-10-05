//
//  Config.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/9/23.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import Foundation


struct Config {
    static let Application = ApplicationConfig()
    static let Text = TextConfig()
}

struct TextConfig {
    let COURSE = "Course"
    let COURSE_ROOM_TIME = "CourseRoomTime"
    let SETTING = "Setting"
    let COURSE_DB_FILE_NAME = "course"
    let SETTING_LATEST_SEMESTER = "latestSemester"
    let SETTING_ILMS_ACCOUNT = "ilmsAccount"
    let SETTING_ILMS_PASSWORD = "ilmsPassword"
    let SETTING_ILMS_NAME = "ilmsName"
    let SETTING_ILMS_EMAIL = "ilmsEmail"
    let SETTING_ILMS_DEPARTMENT = "ilmsDepartment"
}

struct ApplicationConfig {
    let ilmsDomain = "https://lms.nthu.edu.tw"
    let courseServerDomain = "https://nthu-course.feveral.me"
}
