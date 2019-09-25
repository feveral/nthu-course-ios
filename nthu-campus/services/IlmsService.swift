//
//  ilmsService.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/9/21.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

class IlmsService {
    
    static func login(_ account: String, _ password: String) -> Promise<IlmsLoginInfo> {
        return Promise<IlmsLoginInfo> { seal in
            let apiRequest = APIRequest("\(Config.Application.ilmsDomain)/sys/lib/ajax/login_submit.php?account=\(account)&password=\(password)&ssl=1&stay=0")
            apiRequest.getJsonAndHeader().done { (arg) in
                let (json, header) = arg
                seal.fulfill(IlmsLoginInfo(account, password, json, header))
            } .catch { error in
                seal.reject(error)
            }
        }
    }
    
    static func getCoursesIds(_ cookie: String) -> Promise<[String]> {
        return Promise<[String]> { seal in
            let apiRequest = APIRequest("\(Config.Application.ilmsDomain)/home.php?f=allcourse")
            apiRequest.addHeader(key: "Cookie", value: cookie)
            apiRequest.getHtml().done { html in
                let courseIds = ServiceUtils.parseCourseHtmlToCourseIds(html)
                seal.fulfill(courseIds)
            } .catch { error in
                seal.reject(error)
            }
        }
    }
}
