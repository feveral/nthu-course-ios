//
//  StringUtils.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/10/1.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import Foundation


class StringUtils {
    
    static func preprocessQuote(_ target: String) -> String {
        let targetNSString = NSString(string: target)
        let result = targetNSString.replacingOccurrences(of: "'", with: "''")
        return result
    }
}
