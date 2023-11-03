//
//  LoginVC.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 19/10/2023.
//

import UIKit
import FirebaseCore
import GoogleSignIn
import FirebaseAuth

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
//        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//
//        // Create Google Sign In configuration object.
//        let config = GIDConfiguration(clientID: clientID)
//        GIDSignIn.sharedInstance.configuration = config
//
//        // Start the sign in flow!
//        GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
//            guard error == nil else {
//              self.showAlert(message: "\( String(describing: error?.localizedDescription))", actionType: .default)
//              return
//          }
//
//          guard let user = result?.user,
//            let idToken = user.idToken?.tokenString
//          else {
//              return
//            // ...
//          }
//
//          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
//                                                         accessToken: user.accessToken.tokenString)
//            
//            }
//       
//    
   }
//    func performLogic (UserName : String){
//       
//        loginModel.checkCustomerInfo(userName: UserName, userPassword: String)
//        let vc = TabController()
//       // vc.userEmail =  UserData.userEmail
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    func getUserData() -> Bool {
        if UserPasswordTextField.text?.isEmpty == false {
            if UserNameTextField.text?.isEmpty == false {
                return true
            }
        }
        return false
    }
    
   
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
