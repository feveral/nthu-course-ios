//
//  CurriculumController.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/9/12.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import UIKit
import Toaster
import PromiseKit
import NVActivityIndicatorView

class CurriculumPageController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: Properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var weekBar: UIStackView!
    let collectionStatus = CurriculumCollectionStatus()
    let isLoading: Bool = false
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionStatus.cellCount();
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionStatus.buildCell(collectionView, indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionStatus.buildCellFrame(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionStatus.clickCell(self, indexPath)
    }
    
    func loadCourses() {
        CourseService.getLatestSemester().done { courseSemester in
            let allCourse = Course.findAllCourse()
            for c in allCourse {
                print(c.courseId, c.chineseName, c.credits, c.complete)
            }
            var coursesInSemester: [Course] = []
            for c in allCourse {
                if (CourseSemester.isCourseInSemester(courseSemester, c)) {
                    coursesInSemester.append(c)
                }
            }
            self.collectionStatus.setCourses(coursesInSemester)
            self.collectionView.reloadData()
        }.catch { error in
            print(error)
        }
    }
    
    func fetchAndSaveCourseFromIlms() {
        let account = Setting.find(Config.Text.SETTING_ILMS_ACCOUNT)
        let password = Setting.find(Config.Text.SETTING_ILMS_PASSWORD)
        IlmsService.login(account, password)
        .then { ilmsLoginInfo -> Promise<[(String, String)]> in
            IlmsLoginInfo.save(ilmsLoginInfo)
            return IlmsService.getCoursesIdAndNameList()
        } .then { courseIdAndNameList in
            return CourseService.getCourses(courseIdAndNameList)
        } .done { courses in
            Course.deleteAll()
            Course.saveMany(courses)
            self.loadCourses()
            Toast(text: "課表載入成功").show()
        } .catch { error in
            Toast(text: "課表載入失敗，請確認帳號密碼是否輸入正確\n或是否有連上網路").show()
            print(error)
        }
    }

    @IBAction func refreshButtonClick(_ sender: Any) {
        fetchAndSaveCourseFromIlms()
    }
    
    func initialWeekBar() {
        let weekList = ["一", "二", "三", "四", "五"]
        let width = UIScreen.main.bounds.width
        for w in weekList {
            let label = UILabel(frame: CGRect(x:0, y:0, width: width, height: 40))
            label.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
            label.text = w
            label.textAlignment = .center
            weekBar.addArrangedSubview(label)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewFlowLayout.minimumLineSpacing = 0
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionViewFlowLayout.scrollDirection = .vertical
        initialWeekBar()
        loadCourses()
    }
}
