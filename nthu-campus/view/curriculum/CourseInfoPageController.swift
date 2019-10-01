//
//  CourseInfoController.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/9/25.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class CourseInfoPageController: UIViewController {

    var course: Course!
    
    @IBOutlet weak var courseIdLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var courseRoomTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseIdLabel.text = course.courseId
        courseNameLabel.text = course.chineseName
        teacherLabel.text = course.teacher
        creditLabel.text = String(course.credits) + " 學分"
        courseRoomTimeLabel.text = course.roomTime.toString()
        let activityIndicatorView = (NVActivityIndicatorView(frame: CGRect(x: 100, y:100, width: 100, height:100), type: NVActivityIndicatorType.ballScaleMultiple, color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)))
        activityIndicatorView.startAnimating()
        view.addSubview(activityIndicatorView)
        
    }
}
