//
//  SignUpViewModel.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 28/10/2023.
//

import Foundation
import FirebaseAuth

struct SignUpData {
    var userFirstName : String
    var userLastName : String
    var userPassword : String
    var userEmail : String
    var userPhoneNumber : String
}


class SignUpViewModel {
    let manager  = NetworkServices()
    var messageText : String = ""
    var bindresultToProductsViewController : (() -> ()) = {} 
  //  var getLogindata : (() -> SignUpData?) = {return nil}
    var data : SignUpData? = nil
    //var createinApi : (() -> ()) = {}
    
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
        
        manager.CreateCustomer(userFirstName: userFirstName, userLastName: userLastName, userPassword: userPassword, userEmail: userEmail, userPhoneNumber: userPhoneNumber)
    }
    func sendEmailToUser(email : String){
        Auth.auth().currentUser?.sendEmailVerification { [self] error in
            // ...
            if error != nil {
                
                print("===============================")
                print("error from sending email \(String(describing: error?.localizedDescription))")
                self.messageText = error!.localizedDescription
                self.bindresultToProductsViewController()
                print("===============================")
            }
            else {
                
                print("===============================")
                print("Email sent successfully please go check your emails")
                self.messageText = "Email sent successfully please go check your emails"
                self.bindresultToProductsViewController()
                print("===============================")
               
                self.CreateUser(userFirstName: self.data!.userFirstName, userLastName:self.data!.userLastName, userPassword: self.data!.userPassword, userEmail: self.data!.userEmail, userPhoneNumber: self.data!.userPhoneNumber)
                
            }
        }
    }
    
    func createUserInFirebase(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
         
            if let e = error {
                self.messageText =  e.localizedDescription
                self.bindresultToProductsViewController()
            }
            else {
                self.sendEmailToUser(email: email)
                
            }
        }
    }
    //MARK: - adding user information to user defaults
    func  setCustomerId(customerEmail : String) {
        manager.getCustomerByEmail(userEmail: customerEmail, Handler: { (dataValue:CustomerList?, error: Error?) in
            if let mydata = dataValue {
                
                UserDefaultsHelper.shared.saveAPI(id: mydata.customers[0].id ?? 0)
                let customerId = mydata.customers[0].id ?? 0
                UserDefaultsHelper.shared.setCustomerId(customerId)
                
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
