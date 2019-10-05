//
//  CourseSearchTableStatus.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/10/5.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import Foundation
import UIKit

class CourseSearchTableStatus {
    
    var courseList: [Course] = []

    init() {
        
    }

    func addCourses(_ courses: [Course]) {
        courseList += courses
    }
    
    func cellCount() -> Int {
        return courseList.count
    }

    func buildCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseTableCell") as! CourseTableCell
        cell.courseIdLabel.text = courseList[indexPath.row].courseId
        cell.courseNameLabel.text = courseList[indexPath.row].chineseName
        cell.creditLabel.text = "\(courseList[indexPath.row].credits) 學分"
        return cell
    }

    func clickCell(_ viewController: UIViewController, _ indexPath: IndexPath) {
        print("clicked")
    }
}
