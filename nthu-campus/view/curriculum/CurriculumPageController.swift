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
    var activityIndicatorView: NVActivityIndicatorView! = nil
    
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
    
    func setLoadingStatus(_ isLoading: Bool) {
        if (isLoading) {
            self.activityIndicatorView.startAnimating()
            UIView.animate(withDuration: 0.4, animations: {
                self.activityIndicatorView.alpha = 1
                self.collectionView.alpha = 0
            }, completion: nil)
        } else {
            self.activityIndicatorView.stopAnimating()
            UIView.animate(withDuration: 0.4, animations: {
                self.collectionView.alpha = 1
                self.activityIndicatorView.alpha = 0
            }, completion: nil)
        }
    }
    
    func loadCourses() {
        let courseSemester = CourseSemester.find()
        let coursesInSemester: [Course] = Course.findInSemester(courseSemester)
        self.collectionStatus.setCourses(coursesInSemester)
        self.collectionView.reloadData()
    }
    
    func fetchAndSaveCourseFromIlms() {
        self.setLoadingStatus(true)
        let account = Setting.find(Config.Text.SETTING_ILMS_ACCOUNT)
        let password = Setting.find(Config.Text.SETTING_ILMS_PASSWORD)
        IlmsService.login(account, password)
        .then { ilmsLoginInfo -> Promise<[(String, String)]> in
            IlmsLoginInfo.save(ilmsLoginInfo)
            return IlmsService.getCoursesIdAndNameList()
        } .then { courseIdAndNameList in
            return CourseService.getCourses(courseIdAndNameList)
        } .then { courses -> Promise<CourseSemester> in
            Course.deleteAll()
            Course.saveMany(courses)
            return CourseService.getLatestSemester()
        } .done { courseSemester in
            CourseSemester.save(courseSemester)
            self.loadCourses()
            self.setLoadingStatus(false)
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
    
    func initialLoadingView() {
        let x = (UIScreen.main.bounds.width / 2) - 25
        let y = (UIScreen.main.bounds.height / 2)
        activityIndicatorView = (NVActivityIndicatorView(frame: CGRect(x: x, y:y, width: 50, height:50), type: NVActivityIndicatorType.orbit, color: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
        view.addSubview(activityIndicatorView)
        setLoadingStatus(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewFlowLayout.minimumLineSpacing = 0
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionViewFlowLayout.scrollDirection = .vertical
        initialWeekBar()
        initialLoadingView()
        loadCourses()
    }
}
