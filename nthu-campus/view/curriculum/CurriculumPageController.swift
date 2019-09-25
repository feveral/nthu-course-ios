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
    let fullScreenSize = UIScreen.main.bounds.width
    let collectionStatus = CurriculumCollectionStatus()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionStatus.cellCount();
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionStatus.buildCell(collectionView, indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let courseWidth = Int(((fullScreenSize-50) / 5))
        if (indexPath.item % 6 == 0) {
            return CGSize(width: 50, height: 70)
        } else if (indexPath.item % 6 == 5) {
            return CGSize(width: CGFloat((Int(fullScreenSize) - 50) - courseWidth*4) , height: 70)
        }
        return CGSize(width: courseWidth, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionStatus.clickCell(self, indexPath)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewFlowLayout.minimumLineSpacing = 0
        collectionViewFlowLayout.minimumInteritemSpacing = 0
        collectionViewFlowLayout.scrollDirection = .vertical
        
        IlmsService.login("108062613", "09251207")
          .then { ilmsLoginInfo in
            return IlmsService.getCoursesIds(ilmsLoginInfo.getCookieHeaderValue())
        } .then { courseIds in
            return CourseService.getCourses(courseIds)
        } .done { courses in
            Course.deleteAll()
            Course.saveMany(courses)
            print(Course.findAllCourse())
            self.collectionStatus.setCourses(courses)
            self.collectionView.reloadData()
        } .catch { error in
            print(error)
        }
    }
}
