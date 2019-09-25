//
//  CurriculumColor.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/9/24.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import Foundation
import UIKit

class CurriculumCourseColor {
    
    var defaultColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    var colors: [UIColor] = [#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0, green: 0.630137682, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.5212053061, blue: 1, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)]
    var courses: [Course] = []
    
    init() {
        self.colors.shuffle()
    }
    
    func setCourses(_ courses: [Course]) {
        self.courses = courses
    }
    
    func getColor(_ course: Course) -> UIColor {
        for (index,c) in self.courses.enumerated() {
            if (course.courseId == c.courseId && index < colors.count) {
                return colors[index]
            }
        }
        return defaultColor
    }
}
