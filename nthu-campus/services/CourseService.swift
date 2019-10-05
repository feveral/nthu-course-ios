//
//  courseService.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/9/22.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import Foundation
import PromiseKit
import SwiftyJSON
import Alamofire

class CourseService {

    static func getCourseByFilter(semester: CourseSemester? = CourseSemester(""), department: String?="", type: Int?=0, limit: Int?=20, skip: Int?=0) -> Promise<[Course]>{
        let semesterQS = (semester!.get() != "") ? "semester=\(semester!.get())" : ""
        let departmentQS = (department != "") ? "department=\(department!)" : ""
        let typeQS = "type=\(type!)"
        let limitQS = "limit=\(limit!)"
        let skipQS = "skip=\(skip!)"
        
        return Promise<[Course]> { seal in
            let apiRequest = APIRequest("\(Config.Application.courseServerDomain)/course?\(semesterQS)&\(departmentQS)&\(typeQS)&\(limitQS)&\(skipQS)")
            apiRequest.get().done { json in
                if (json["status"].bool! == true) {
                    var courseList: [Course] = []
                    for (_, course):(String, JSON) in json["courses"] {
                        courseList.append(Course.jsonToCourse(course))
                    }
                    seal.fulfill(courseList)
                } else {
                    seal.reject(NSError(domain: "coursesAPIResponseError", code: 1000, userInfo: ["json": json]))
                }
            } .catch { error in
                seal.reject(error)
            }
        }

    }
    
    static func getCourses(_ courseIdAndNameList: [(String, String)]) -> Promise<[Course]> {
        let promises = courseIdAndNameList.map{ (courseId, courseName) -> Promise<Course> in
            return Promise { seal in
                let apiRequest = APIRequest("\(Config.Application.courseServerDomain)/course/\(courseId)")
                apiRequest.get().done { json in
                    if (json["status"].bool! == true) {
                        seal.fulfill(Course.jsonToCourse(json["course"]))
                    } else {
                        seal.fulfill(Course(courseId: courseId, chineseName: courseName, complete: false))
                    }
                }.catch { error in
                    seal.reject(error)
                }
            }
        }
        return when(fulfilled: promises)
    }
    
    static func getLatestSemester() -> Promise<CourseSemester> {
        return Promise<CourseSemester> { seal in
            let apiRequest = APIRequest("\(Config.Application.courseServerDomain)/course/semester/latest")
            apiRequest.get().done { json in
                if let semester = json["semester"].string {
                    seal.fulfill(CourseSemester(semester))
                } else {
                    seal.reject(NSError(domain: "jsonNotExpect", code: 1001, userInfo: ["json":json]))
                }
            }.catch {error in
                seal.reject(error)
            }
        }
    }
}
