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
        //TODO: for loop can using "thenMap" in promise
        return Promise<[Course]> { seal in
            
        }
    }
}
