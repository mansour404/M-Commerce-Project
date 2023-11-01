//
//  SignUpVC.swift
//  finalprojectmock
//
//  Created by Ziyad Qassem on 18/10/2023.
//

import UIKit

class SignUpVC: UIViewController {
    @IBOutlet weak var userNamefield: UITextField!
    @IBOutlet weak var userPasswordfield: UITextField!
    @IBOutlet weak var userEmailAdressfield: UITextField!
    @IBOutlet weak var userPhoneNumberfield: UITextField!
   let signUpViewModel = SignUpViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func SignUpPressed(_ sender: UIButton) {
//        if(textFieldIsNotEmpty()){
//            if( signUpViewModel.isDataValid(phoneNumber: userPhoneNumberfield.text!, emailAdress: userEmailAdressfield.text!, userPassword: userPasswordfield.text!)){
//                let arr  : [String] = sperateUserName(userName: userNamefield.text!)
//                signUpViewModel.bindresultToProductsViewController = {
//                    self.showAlert(message: "User Created Successfully", actionType: .default)
//                }
//                //create user in api
//                signUpViewModel.CreateUser(userFirstName: arr[0], userLastName: arr[1], userPassword: userPasswordfield.text!, userEmail: userEmailAdressfield.text!, userPhoneNumber: userPhoneNumberfield.text!)
//                signUpViewModel.bindresultToProductsViewController = {
//                    self.showAlert(message: self.signUpViewModel.errorDescription, actionType: .default)
//                }
//
//                //create user in fireBase
//
//
//                signUpViewModel.createUserInFirebase(email:  userEmailAdressfield.text!, password: userPasswordfield.text!)
//            }
//                else {
//                    showAlert(message: "Data is not Vaild", actionType: .cancel)
//           }
//        }
//        else {
//            showAlert(message: "There is a one or more empty Field", actionType: .cancel)
//        }
        print(userEmailAdressfield.text!)
        signUpViewModel.sendEmailToUser(email: userEmailAdressfield.text!)
        
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
        
        if components.count >= 2 {
            let firstString = components[0].trimmingCharacters(in: .whitespaces)
           
            let secondString = components[1].trimmingCharacters(in: .whitespaces)
            
        }
        return components
        
    }
    func showAlert(message:String , actionType : UIAlertAction.Style){
             let alert = UIAlertController(title: message, message: message, preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "okay", style: actionType))
                 
             self.present(alert, animated: true)
         }
    
}
