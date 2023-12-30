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
        UserPasswordTextField.isSecureTextEntry = true

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
            else {
                self.showAlert(message: "User doesn't exi", actionType: .default)
            }
        }else {
            self.showAlert(message: "you've left a field empty please enter your password and your name", actionType: .default)
        }
    }
    
    @IBAction func GoogleButton(_ sender: UIButton) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
            guard error == nil else {
          
              return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
              return
            // ...
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)
           if ( self.performLogic(UserName: user.profile!.name, userEmail: user.profile!.email) == false)
            {
               self.showAlert(message: "User doesn't exist please Sign up ", actionType: .default)
           }
           
            
            }
       
    
   }
    
    func performLogic (UserName : String,userEmail : String) -> Bool {

        loginModel.bindresultToProductsViewController = {
            let vc = TabController()
            // vc.userEmail =  UserData.userEmail
            vc.modalPresentationStyle = .fullScreen
            
            self.present(vc, animated: true)
        }
        return  loginModel.checkCustomerInfoIngoogleSignIn(userName: UserName, userEmail: userEmail)
            
        
        
    }
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
    func showAlert(message:String , actionType : UIAlertAction.Style){
        let alert = UIAlertController(title: message, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "okay", style: actionType))
        
        self.present(alert, animated: true)
    }
}
