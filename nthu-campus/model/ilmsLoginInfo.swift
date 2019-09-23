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
    var name: String
    var email: String
    var department: String
    var cookieValue: String
    
    init(_ account: String, _ password: String, _ loginResponseJson: JSON, _ loginResponseHeader: Header) {
        self.account = account
        self.name = loginResponseJson["ret"]["name"].string!
        self.email = loginResponseJson["ret"]["email"].string!
        self.department = loginResponseJson["ret"]["divName"].string!
        self.cookieValue = loginResponseHeader.getSetCookieHeaders()
    }
    
    func getCookieHeaderValue() -> String {
        return cookieValue
    }
}
