//
//  Header.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/9/21.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import Foundation

class Header {
    
    private var dict: [String: String] = [:]
    
    init(_ hashables: [AnyHashable: Any]) {
        for (k,v) in hashables {
            self.dict[k as! String] = (v as! String)
        }
    }
    
    public func getAllHeaders() -> Dictionary<String, String> {
        return self.dict
    }
    
    public func getHeader(key: String) -> String {
        return dict[key] ?? ""
    }
    
    public func getSetCookieHeaders() -> String {
        return dict["Set-Cookie"] ?? ""
    }
}
