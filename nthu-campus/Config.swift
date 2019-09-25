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
    let COURSE_DB_FILE_NAME = "course"
}

struct ApplicationConfig {
    let ilmsDomain = "https://lms.nthu.edu.tw"
    let courseServerDomain = "https://nthu-course.feveral.me"
}
