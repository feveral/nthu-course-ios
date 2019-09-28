//
//  CurriculumController.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/9/12.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import UIKit

class CurriculumPageController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: Properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    let collectionStatus = CurriculumCollectionStatus()
    let loadSuccessful: Bool = false
    
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
        if (!Course.isAnyCourseExist()) {
            fetchAndSaveCourseFromIlms()
        } else {
            self.collectionStatus.setCourses(Course.findAllCourse())
            self.collectionView.reloadData()
        }
    }
    
    func fetchAndSaveCourseFromIlms() {
        if let account = Setting.find(Config.Text.SETTING_ILMS_ACCOUNT),
            let password = Setting.find(Config.Text.SETTING_ILMS_PASSWORD) {
            IlmsService.login(account, password)
                .then { ilmsLoginInfo in
                    return IlmsService.getCoursesIds(ilmsLoginInfo.getCookieHeaderValue())
                } .then { courseIds in
                    return CourseService.getCourses(courseIds)
                } .done { courses in
                    Course.deleteAll()
                    Course.saveMany(courses)
                    self.collectionStatus.setCourses(courses)
                    self.collectionView.reloadData()
                } .catch { error in
                    print(error)
                }
        } else {
            print("account password fail")
        }
    }
    
    @IBAction func refreshButtonClick(_ sender: Any) {
        fetchAndSaveCourseFromIlms()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewFlowLayout.minimumLineSpacing = 0
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionViewFlowLayout.scrollDirection = .vertical
        loadCourses()
    }
}
