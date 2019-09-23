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
            let apiRequest = APIRequest("https://lms.nthu.edu.tw/sys/lib/ajax/login_submit.php?account=\(account)&password=\(password)&ssl=1&stay=0")
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
            let apiRequest = APIRequest("https://lms.nthu.edu.tw/home.php?f=allcourse")
            apiRequest.addHeader(key: "Cookie", value: cookie)
            apiRequest.getHtml().done { html in
                let courseIds = ServiceUtils.parseCourseHtmlToCourseIds(html)
                seal.fulfill(courseIds)
            } .catch { error in
                seal.reject(error)
            }
        }
    }
    
//    static func login(_ account: String, _ password: String, _ completion: @escaping (Result<IlmsLoginInfo, APIError>) -> Void) {
//        let apiRequest = APIRequest(endpoint: "https://lms.nthu.edu.tw/sys/lib/ajax/login_submit.php?account=\(account)&password=\(password)&ssl=1&stay=0")
//        apiRequest.getWithHeaders { (result) in
//            switch result {
//            case .success(let (json, header)):
//                let ilmsLoginInfo = IlmsLoginInfo("108062613", json, header)
//                completion(.success(ilmsLoginInfo))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//
//    // Based on ilms login
//    static func getCoursesIds(cookie: String, _ completion: @escaping (Result<[String], APIError>) -> Void) {
//        let apiRequest = APIRequest(endpoint: "https://lms.nthu.edu.tw/home.php?f=allcourse")
//        apiRequest.addHeader(key: "Cookie", value: cookie)
//        apiRequest.getHTML { (result) in
//            switch result {
//            case .success(let html):
//                let courseIds = ServiceUtils.parseCourseHtmlToCourseIds(html)
//                completion(.success(courseIds))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
}
