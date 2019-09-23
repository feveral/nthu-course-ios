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
