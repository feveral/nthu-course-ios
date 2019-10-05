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
        hideKeyboardWhenTappedAround()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        ilmsAccountTextField.resignFirstResponder()
        ilmsPasswordTextField.resignFirstResponder()
    }
    
    func clearCookies() {
        let cstorage = HTTPCookieStorage.shared
        if let cookies = cstorage.cookies(for: URL(string: Config.Application.ilmsDomain)!) {
            for cookie in cookies {
                cstorage.deleteCookie(cookie)
            }
        }
    }
    
    @IBAction func saveAccountInfo(_ sender: Any) {
        Setting.set(Config.Text.SETTING_ILMS_ACCOUNT, ilmsAccountTextField.text!)
        Setting.set(Config.Text.SETTING_ILMS_PASSWORD, ilmsPasswordTextField.text!)
        clearCookies()
        let alert = UIAlertController(title: "帳號資訊儲存成功", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "好", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
