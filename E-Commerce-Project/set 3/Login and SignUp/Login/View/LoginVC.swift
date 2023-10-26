//
//  LoginVC.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 19/10/2023.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var googleBtnOutlet: UIButton!
    @IBOutlet weak var loginBtnOutlet: UIButton!
    @IBOutlet weak var UserPasswordTextField: UITextField!
    @IBOutlet weak var UserNameTextField: UITextField!
    let loginModel  = LoginViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        googleBtnOutlet.layer.cornerRadius = 13
        loginBtnOutlet.layer.cornerRadius = 13
        loginModel.getDataFromApiForCustom()

    }
    //MARK: - ACTIONS
    @IBAction func LoginButton(_ sender: UIButton) {
        if getUserData() {
            if loginModel.checkCustomerInfo(userName: UserNameTextField.text!, userPassword: UserPasswordTextField.text!){
                let vc = TabController()
//                navigationController?.pushViewController(vc, animated: true)
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
             }
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
