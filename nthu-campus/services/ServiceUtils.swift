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
    
    static func parseCourseHtmlToCourseIdAndNameList(_ html: String) -> [(String,String)] {
        do {
            var resultList: [(String, String)] = []
            let doc: Document = try SwiftSoup.parse(html)
            let courseIdElements: Elements = try doc.select(".listFirstTD")
            let courseNameElements: Elements = try doc.select(".listTD > a")
            for (index, ele) in courseNameElements.array().enumerated() {
                if (ele.children().count == 0) {
                    let linkTextCourseName: String = try ele.text()
                    let linkTextCourseId = try courseIdElements.array()[index].text()
                    resultList.append((linkTextCourseId, linkTextCourseName))
                }
            }
            return resultList
        } catch {
            print("error")
            return []
        }
    }
}
