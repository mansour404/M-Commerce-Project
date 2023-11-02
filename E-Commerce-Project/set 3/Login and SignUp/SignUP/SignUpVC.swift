//
//  SignUpVC.swift
//  finalprojectmock
//
//  Created by Ziyad Qassem on 18/10/2023.
//

import UIKit
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

class SignUpVC: UIViewController {
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var userNamefield: UITextField!
    @IBOutlet weak var userPasswordfield: UITextField!
    @IBOutlet weak var userEmailAdressfield: UITextField!
    @IBOutlet weak var userPhoneNumberfield: UITextField!
    let signUpViewModel = SignUpViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(googleSigninTapped)))
        
    }
    @objc func googleSigninTapped(){
        print("=================================================")
        print("google sign in pressed")
        print("=================================================")
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
          guard error == nil else {
            // ...
             
              self.showAlert(message: "\( error?.localizedDescription)", actionType: .default)
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
            
            
            print("=================================================")
            print(result?.user.profile?.email)
            print("=================================================")
            print(result?.user.profile?.familyName)
            print("=================================================")
            print(result?.user.profile?.name)
            print("=================================================")
            Auth.auth().signIn(with: credential) { result, error in
                if error != nil {
                    
                }
                else{
//                    let arr = self.sperateUserName(userName: result?.user.profile?.name)
//                    self.signUpViewModel.CreateUser(userFirstName: arr[0], userLastName: arr[1], userPassword: "placeHolder", userEmail: result?.user.profile?.email, userPhoneNumber: "01010101010")
                }
             
            }

          // ...
        }
    
    }
    @IBAction func SignUpPressed(_ sender: UIButton) {
        if(textFieldIsNotEmpty()){
            if( signUpViewModel.isDataValid(phoneNumber: userPhoneNumberfield.text!, emailAdress: userEmailAdressfield.text!, userPassword: userPasswordfield.text!)){
                let arr  : [String] = sperateUserName(userName: userNamefield.text!)
                signUpViewModel.bindresultToProductsViewController = {
                    self.showAlert(message: self.signUpViewModel.messageText, actionType: .default)
                }
                signUpViewModel.data = SignUpData(userFirstName: arr[0], userLastName: arr[1], userPassword: self.userPasswordfield.text! , userEmail: self.userEmailAdressfield.text!, userPhoneNumber: self.userPhoneNumberfield.text!)
                
                signUpViewModel.createUserInFirebase(email: userEmailAdressfield.text!, password: userPasswordfield.text!)
                
            }
            else {
                showAlert(message: "Data is not Vaild", actionType: .cancel)
            }
        }
        else {
            showAlert(message: "There is a one or more empty Field", actionType: .cancel)
        }
        //        print(userEmailAdressfield.text!)
        //        signUpViewModel.sendEmailToUser(email: userEmailAdressfield.text!)
        
    }
    
  
    
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    func textFieldIsNotEmpty () ->Bool {
        let arr : [String?] = [userNamefield.text,userPasswordfield.text,userEmailAdressfield.text ,userPhoneNumberfield.text]
        var check = true
        for s in arr {
            if (s?.isEmpty == true){
                check = false
                break
            }
            
        }
        return check
    }
    func sperateUserName(userName : String) ->[String]{
        let components = userName.components(separatedBy: " ")
        
        
        return components
        
    }
    func showAlert(message:String , actionType : UIAlertAction.Style){
        let alert = UIAlertController(title: message, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "okay", style: actionType))
        
        self.present(alert, animated: true)
    }
    
}
