//
//  CourseSemester.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/9/28.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import Foundation

class CourseSemester {
    
    var semester: String
    
    // example: "10810"
    init(_ semester: String) {
        self.semester = semester
    }
    
    func get() -> String {
        return semester
    }
    
    static func isCourseInSemester(_ semester: CourseSemester, _ course: Course) -> Bool {
        if (course.courseId.contains(semester.get())) {
            return true
        }
        return false
    }
}
