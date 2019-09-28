//
//  CurriculumCollectionStatus.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/9/24.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import Foundation
import UIKit

class CurriculumCollectionStatus {
    
    var courseList: [Course] = []
    var courseColor: CurriculumCourseColor = CurriculumCourseColor()
    
    public func setCourses(_ courses: [Course]) {
        courseList = courses
        courseColor.setCourses(courses)
    }
    
    private func getCourseInTimeSlot(_ timeSlot: CourseTimeSlot) -> Course? {
        for c in courseList {
            if (c.isTimeSlotExist(timeSlot)) {
                return c
            }
        }
        return nil
    }
    
    private func collectionIndexToCourseTimeSlot(_ index: Int) -> CourseTimeSlot {
        var dayOfWeek: DayOfWeek = .other
        var coursePeriod: CoursePeriod = .other
        if (index % 6 == 1) { dayOfWeek = .monday }
        else if (index % 6 == 2) { dayOfWeek = .tuesday }
        else if (index % 6 == 3) { dayOfWeek = .wednesday }
        else if (index % 6 == 4) { dayOfWeek = .thursday }
        else if (index % 6 == 5) { dayOfWeek = .friday }
        
        if (index / 6 == 0) { coursePeriod = .period1 }
        else if (index / 6 == 1) { coursePeriod = .period2 }
        else if (index / 6 == 2) { coursePeriod = .period3 }
        else if (index / 6 == 3) { coursePeriod = .period4 }
        else if (index / 6 == 4) { coursePeriod = .period5 }
        else if (index / 6 == 5) { coursePeriod = .period6 }
        else if (index / 6 == 6) { coursePeriod = .period7 }
        else if (index / 6 == 7) { coursePeriod = .period8 }
        else if (index / 6 == 8) { coursePeriod = .period9 }
        else if (index / 6 == 9) { coursePeriod = .perioda }
        else if (index / 6 == 10) { coursePeriod = .periodb }
        else if (index / 6 == 11) { coursePeriod = .periodc }
        return CourseTimeSlot(dayOfWeek, coursePeriod)
    }
    
    public func cellCount() -> Int {
        return (1 + 5) * 12
    }
    
    public func buildCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "courseCollectionCell", for: indexPath) as! CourseCollectionCell
        cell.nameLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        let timeSlot = collectionIndexToCourseTimeSlot(indexPath.item)
        if let course = getCourseInTimeSlot(timeSlot) {
            cell.course = course
            cell.nameLabel?.text = course.chineseName
            cell.nameLabel?.backgroundColor = courseColor.getColor(course)
            return cell
        }
        if (indexPath.item % 6 == 0) {
            cell.nameLabel?.text = getTimeStringByCollecitonIndex(indexPath.item)
            cell.nameLabel?.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            return cell
        }
        cell.nameLabel?.text = ""
        cell.nameLabel?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return cell
    }
    
    public func buildCellFrame(_ indexPath: IndexPath) -> CGSize {
        let fullScreenSize = UIScreen.main.bounds.width
        let courseWidth = Int(((fullScreenSize-50) / 5))
        if (indexPath.item % 6 == 0) {
            return CGSize(width: 50, height: 70)
        } else if (indexPath.item % 6 == 5) {
            return CGSize(width: CGFloat((Int(fullScreenSize) - 50) - courseWidth*4) , height: 70)
        }
        return CGSize(width: courseWidth, height: 70)
    }
    
    public func clickCell(_ viewController: UIViewController, _ indexPath: IndexPath) {
//        let vc = CourseInfoPageController()
//        vc.text = "courseinfopage"
//        viewController.navigationController?.pushViewController(vc, animated: true)
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "newViewController") as! NewViewController
//        self.present(newViewController, animated: true, completion: nil)
    }
    
    private func getTimeStringByCollecitonIndex(_ index: Int) -> String{
        if (index == 6 * 0) { return "1\n8:00" }
        if (index == 6 * 1) { return "2\n9:00" }
        if (index == 6 * 2) { return "3\n10:10" }
        if (index == 6 * 3) { return "4\n11:10" }
        if (index == 6 * 4) { return "5\n13:20" }
        if (index == 6 * 5) { return "6\n14:20" }
        if (index == 6 * 6) { return "7\n15:30" }
        if (index == 6 * 7) { return "8\n16:30" }
        if (index == 6 * 8) { return "9\n17:30" }
        if (index == 6 * 9) { return "a\n18:30" }
        if (index == 6 * 10) { return "b\n19:30" }
        if (index == 6 * 11) { return "c\n20:30" }
        else { return "" }
    }
}
