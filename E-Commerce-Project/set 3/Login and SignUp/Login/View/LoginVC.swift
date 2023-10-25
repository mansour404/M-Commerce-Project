//
//  LoginVC.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 19/10/2023.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var UserPasswordTextField: UITextField!
    @IBOutlet weak var UserNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func LoginButton(_ sender: UIButton) {
        if getUserData() {
            print("not empty")
        }else {
            print("empty")
        }
    }
    
    @IBAction func GoogleButton(_ sender: UIButton) {
    }
    func getUserData() -> Bool {
        if UserPasswordTextField.text?.isEmpty == false {
            if UserNameTextField.text?.isEmpty == false {
                return true
            }
        }
        return false
    }
    
   

}
