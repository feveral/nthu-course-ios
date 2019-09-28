//
//  LoginPageController.swift
//  nthu-campus
//
//  Created by 楊宗翰 on 2019/9/27.
//  Copyright © 2019 楊宗翰. All rights reserved.
//

import UIKit

class SettingPageController: UIViewController {

    @IBOutlet weak var ilmsAccountTextField: UITextField!
    @IBOutlet weak var ilmsPasswordTextField: UITextField!
    @IBOutlet weak var saveAccountInfoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveAccountInfoButton.layer.cornerRadius = 15
        ilmsAccountTextField.text = Setting.find(Config.Text.SETTING_ILMS_ACCOUNT)
        ilmsPasswordTextField.text = Setting.find(Config.Text.SETTING_ILMS_PASSWORD)
    }
    
    @IBAction func saveAccountInfo(_ sender: Any) {
        Setting.setIlmsAccount(ilmsAccountTextField.text!)
        Setting.setIlmsPassword(ilmsPasswordTextField.text!)
        let alert = UIAlertController(title: "帳號資訊儲存成功", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "好", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
