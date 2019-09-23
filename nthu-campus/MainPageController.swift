//
//  ViewController.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/9/12.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import UIKit

class MainPageController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        IlmsService.login("108062613", "09251207")
          .then { ilmsLoginInfo in
            return IlmsService.getCoursesIds(ilmsLoginInfo.getCookieHeaderValue())
        } .done { courseId in
            print(courseId)
        } .catch { error in
            print(error)
        }
        
        //        let apiRequest = APIRequest("https://lms.nthu.edu.tw/sys/lib/ajax/login_submit.php?account=108062613&password=09251207&ssl=1&stay=0")
//        apiRequest.get().done { json in
//            print(json)
//        } .catch { error in
//            print(error)
//        }
        
//        IlmsService.login("108062613", "09251207") { result in
//            switch result {
//            case .success(let ilmsLoginInfo):
//                let cookieValue = ilmsLoginInfo.getCookieHeaderValue()
//                IlmsService.getCoursesIds(cookie: cookieValue) { (result) in
//                    
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
}
