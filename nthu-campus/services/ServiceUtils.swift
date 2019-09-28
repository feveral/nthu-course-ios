//
//  serviceUtils.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/9/21.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import Foundation
import SwiftSoup

class ServiceUtils {
    
    static func isIlmsNoPermissionPage(_ html: String) -> Bool {
        if (html == "<div style='color:#606060; text-align: center; font-size: 13px; border: 1px solid #ccc; margin: 20px; padding: 20px 2px 20px 2px;'>No Permission!</div>") {
            return true
        }
        return false
    }
    
    static func removeParenthesesIfExist(_ jsonData: Data) -> Data {
        var str = String(data: jsonData, encoding: String.Encoding.utf8)!
        if (str.first == "(" ) {
            str.removeFirst()
        }
        if (str.last == ")") {
            str.removeLast()
        }
        return str.data(using: .utf8)!
    }
    
    static func parseCourseHtmlToCourseIds(_ html: String) -> [String] {
        do {
            var courseIds: [String] = []
            let doc: Document = try SwiftSoup.parse(html)
            let elements: Elements = try doc.select(".listFirstTD")
            for ele: Element in elements.array() {
                let linkText: String = try ele.text()
                courseIds.append(linkText)
            }
            return courseIds
        } catch {
            print("error")
            return []
        }
    }
}
