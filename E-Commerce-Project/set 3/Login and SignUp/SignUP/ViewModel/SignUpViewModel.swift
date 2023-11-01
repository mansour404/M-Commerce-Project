//
//  SignUpViewModel.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 28/10/2023.
//

import Foundation
import FirebaseAuth

class SignUpViewModel {
    let manager  = NetworkServices()
    var errorDescription : String = ""
    var bindresultToProductsViewController : (() -> ()) = {}
    
    private let format = "SELF MATCHES %@"
    //MARK: - Validate user Info
    func isDataValid(phoneNumber : String , emailAdress : String , userPassword : String) -> Bool {
        guard isValidPhone(number: phoneNumber) else {
                return false
            }
            guard isValidEmail(email: emailAdress) else {

                return false
            }
//            guard isValidPassword(password: userPassword) else {
//                return false
//            }
            return true
        }
    //MARK: - create customer in api and FireBase
    func CreateUser (userFirstName : String ,userLastName : String ,userPassword : String , userEmail : String , userPhoneNumber : String ) {
        
        manager.CreateCustomer(userFirstName: userFirstName, userLastName: userLastName, userPassword: userPassword, userEmail: userEmail, userPhoneNumber: userPhoneNumber,  Handler:{
            print("Done")
            self.bindresultToProductsViewController()
            self.createUserInFirebase(email: userEmail, password: userPassword)
         
        
        })
    }
    func sendEmailToUser(email : String){
        Auth.auth().currentUser?.sendEmailVerification { error in
          // ...
            if error != nil {
                print("===============================")
                print("error from sending email \(error?.localizedDescription)")
                print("===============================")
            }
            else {
                print("===============================")
                print("email sent successfully please go check your emails")
                print("===============================")
            }
        }
    }
    
    func createUserInFirebase(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                self.errorDescription =  e.localizedDescription
                self.bindresultToProductsViewController()
            }
            else {
                
            }
        }
        }
    //MARK: - adding user information to user defaults
    func  setCustomerId(customerEmail : String) {
        manager.getCustomerByEmail(userEmail: customerEmail, Handler: { (dataValue:CustomerList?, error: Error?) in
            if let mydata = dataValue {
                
                UserDefaultsHelper.shared.saveAPI(id: mydata.customers[0].id ?? 0)
                
             
            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
        
    }
    func  setCustomerName(CustomerName : String) {
        UserDefaultsHelper.shared.saveCustomerEmail(customerName: CustomerName)
    }
    //MARK: - Authoentication

    func isValidEmail(email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pred = NSPredicate(format: format, regex)
        return pred.evaluate(with: email)
    }
    
    func isValidPassword(password: String) -> Bool {
        let regex = "(?=.[A-Z])(?=.[0-9])(?=.*[a-z]).{8,}"
        let pred = NSPredicate(format: format, regex)
        return pred.evaluate(with: password)
    }
    
    func isValidPhone(number: String?) -> Bool {
        let regex = "^[0-9]{11}$"
        let pred = NSPredicate(format: format, regex)
        return pred.evaluate(with: number)
    }

}
