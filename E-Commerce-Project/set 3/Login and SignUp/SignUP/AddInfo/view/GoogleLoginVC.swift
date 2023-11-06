//
//  GoogleLoginVC.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 20/10/2023.
//

import UIKit

class GoogleLoginVC: UIViewController {

    @IBOutlet weak var userEmaillabel: UILabel!
    @IBOutlet weak var PhoneNumberField: UITextField!
  
    @IBOutlet weak var ConfirmPasswordField: UITextField!
    @IBOutlet weak var NewPasswordFiell: UITextField!
    var userEmail : String = ""
    private let addUserDetailsModel  = AddInfoViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        userEmaillabel.text = userEmail
        addUserDetailsModel.bindresultToProductsViewController = { // set alert message
            let vc = TabController()
            vc.modalPresentationStyle = .fullScreen
        
            self.present(vc, animated: true)
        }
        // Do any additional setup after loading the view.
    }

    func textFieldIsNotEmpty () ->Bool {
        let arr : [String?] = [NewPasswordFiell.text,ConfirmPasswordField.text,PhoneNumberField.text]
        var check = true
        for s in arr {
            if (s?.isEmpty == true){
                check = false
                break
            }
            
        }
        return check
    }
    @IBAction func addPasswordtapped(_ sender: UIButton) {
        if textFieldIsNotEmpty(){              // check if text fields is not empty
            print("inside first if")
//            if(addUserDetailsModel.isDataValid(phoneNumber: PhoneNumberField.text!, userPassword: NewPasswordFiell.text!)){
                // check if user put the same input in confirm and password
                    print("inside  second if")
//                    addUserDetailsModel.showAlert = {
//                        self.showAlert(message: self.addUserDetailsModel.messageText)
//                    }
                    addUserDetailsModel.bindresultToProductsViewController = { // set alert message
                        let vc = NewAddressView()
                        vc.modalPresentationStyle = .fullScreen
                    
                        self.present(vc, animated: true)
                    }
                    // add perform the logic as in getting the user date
                    addUserDetailsModel.getUserData(UserEmail: userEmail, customerPassword: ConfirmPasswordField.text!, customerPhoneNumber: PhoneNumberField.text!)
                    
        
                }
            else{
                showAlert(message: "Data is not vaild please enter your data or you have empty field")
            }
        
    }
    func showAlert(message:String ){
        let alert = UIAlertController(title: message, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "okay", style: .default))
        
        self.present(alert, animated: true)
    }

        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
