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
    
    static func checkIsLogin() -> Promise<Bool> {
        return Promise<Bool> { seal in
            let apiRequest = APIRequest("\(Config.Application.ilmsDomain)/home.php?f=allcourse")
            apiRequest.getHtml().done { html in
                if (ServiceUtils.isIlmsNoPermissionPage(html)) {
                    seal.fulfill(false)
                } else {
                    seal.fulfill(true)
                }
            } .catch { error in
                seal.reject(error)
            }
        }
    }
    
    static func login(_ account: String, _ password: String) -> Promise<IlmsLoginInfo> {
        return Promise<IlmsLoginInfo> { seal in
            IlmsService.checkIsLogin().done { isLogin in
                if (isLogin) {
                    seal.fulfill(IlmsLoginInfo(
                        Setting.find(Config.Text.SETTING_ILMS_ACCOUNT),
                        Setting.find(Config.Text.SETTING_ILMS_PASSWORD),
                        Setting.find(Config.Text.SETTING_ILMS_NAME),
                        Setting.find(Config.Text.SETTING_ILMS_EMAIL),
                        Setting.find(Config.Text.SETTING_ILMS_DEPARTMENT)
                    ))
                } else {
                    print("call login API")
                    let apiRequest = APIRequest("\(Config.Application.ilmsDomain)/sys/lib/ajax/login_submit.php?account=\(account)&password=\(password)&ssl=1&stay=0")
                    apiRequest.get().done { json in
                        if let name = json["ret"]["name"].string,
                            let email = json["ret"]["email"].string,
                            let department = json["ret"]["divName"].string {
                        seal.fulfill(IlmsLoginInfo(account, password, name, email, department))
                        } else {
                            seal.reject(NSError(domain: "loginJsonParseError", code: 1000, userInfo: ["json": json]))
                        }
                    }.catch { error in
                        seal.reject(error)
                    }
                }
            }.catch { error in
                seal.reject(error)
            }
        }
    }
    
    static func getCoursesIdAndNameList() -> Promise<[(String, String)]> {
        return Promise<[(String, String)]> { seal in
            let apiRequest = APIRequest("\(Config.Application.ilmsDomain)/home.php?f=allcourse")
            apiRequest.getHtml().done { html in
                let courseIdAndNameList = ServiceUtils.parseCourseHtmlToCourseIdAndNameList(html)
                seal.fulfill(courseIdAndNameList)
            } .catch { error in
                seal.reject(error)
            }
        }
    }
}
