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
    
    init(_ account: String, _ password: String, _ loginResponseJson: JSON, _ loginResponseHeader: Header) throws {
        self.account = account
        if let name = loginResponseJson["ret"]["name"].string,
            let email = loginResponseJson["ret"]["email"].string,
            let department = loginResponseJson["ret"]["divName"].string {
            self.name = name
            self.email = email
            self.department = department
            self.cookieValue = loginResponseHeader.getSetCookieHeaders()
        } else {
            throw NSError(domain: "jsonResultNotExpect", code: 1000, userInfo: ["json":loginResponseJson])
        }
    }
    
    func getCookieHeaderValue() -> String {
        return cookieValue
    }
}
