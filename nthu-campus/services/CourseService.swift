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
    
    static func getCourses(_ courseIds: [String]) -> Promise<[Course]> {
        let promises = courseIds.map{ courseId -> Promise<Course> in
            return Promise { seal in
                let apiRequest = APIRequest("\(Config.Application.courseServerDomain)/course/\(courseId)")
                apiRequest.get().done { json in
                    seal.fulfill(Course.jsonToCourse(json))
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
