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
    var colors: [UIColor] = [#colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1), #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1), #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1), #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1), #colorLiteral(red: 0.8321695924, green: 0.985483706, blue: 0.4733308554, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), #colorLiteral(red: 0, green: 0.630137682, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.5409764051, blue: 0.8473142982, alpha: 1), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)]
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
