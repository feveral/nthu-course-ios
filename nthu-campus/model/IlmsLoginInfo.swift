//
//  ilmsLoginInfo.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/9/21.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import Foundation
import SwiftyJSON

class IlmsLoginInfo {
    
    var account: String
    var password: String
    var name: String
    var email: String
    var department: String
    
    init(_ account: String, _ password: String, _ name: String, _ email: String, _ department: String) {
        self.account = account
        self.name = name
        self.email = email
        self.password = password
        self.department = department
    }
    
    static func save(_ ilmsLoginInfo: IlmsLoginInfo) {
        Setting.set(Config.Text.SETTING_ILMS_ACCOUNT, ilmsLoginInfo.account)
        Setting.set(Config.Text.SETTING_ILMS_PASSWORD, ilmsLoginInfo.password)
        Setting.set(Config.Text.SETTING_ILMS_NAME, ilmsLoginInfo.name)
        Setting.set(Config.Text.SETTING_ILMS_EMAIL, ilmsLoginInfo.email)
        Setting.set(Config.Text.SETTING_ILMS_DEPARTMENT, ilmsLoginInfo.department)
    }
}
