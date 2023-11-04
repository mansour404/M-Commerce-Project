//
//  AddInfoViewModel.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 03/11/2023.
//

import Foundation
class AddInfoViewModel {
    private let manager = NetworkServices()
   
    var messageText : String = ""
    var bindresultToProductsViewController : (() -> ()) = {}
    var showAlert : (() -> ()) = {}
    var isItokay: Bool? {
        didSet{
            bindresultToProductsViewController()
        }
    }
    //MARK: - get data from api
    func getUserData(UserEmail : String,customerPassword : String ,customerPhoneNumber : String){
        manager.getCustomerByEmail(userEmail: UserEmail, Handler:  {(dataValue:CustomerList?, error: Error?) in
    

            if let mydata = dataValue {
              
                print("==================================================")
                print("success from get user by email ---- \( mydata.customers[0])")
                print("==================================================")
                self.editCustomerData(CustomerId: mydata.customers[0].id!, customerPassword: customerPassword, customerPhoneNumber: customerPhoneNumber)
            }else {
                if let error = error{
                    print("==================================================")
                    print("error from get user by email")
                    print("==================================================")
                    self.messageText = "\(error.localizedDescription)"
                    self.showAlert()
                   
                }
            }
        })
            
        
        
    }
    //MARK: - edit customer information in API
    func editCustomerData (CustomerId :  Int,customerPassword : String ,customerPhoneNumber : String ) {
        manager.editCustomerData(CustomerId: CustomerId, customerPassword: customerPassword, customerPhoneNumber: customerPhoneNumber, Handler: {error in
            if error != nil {
                self.messageText = "\(String(describing: error?.localizedDescription))"
                self.showAlert()
                self.isItokay = false
                
            }
            else{
             
//                self.showAlert()
                self.setCustomerId(customerId: CustomerId)
             
                self.isItokay = true
            }})
        
    }
    //MARK: - add cutomer  to user default
    
    private  func setCustomerId (customerId : Int){
        UserDefaultsHelper.shared.setCustomerId(customerId: customerId)
    }
   
    
    //MARK: - Authoentication  data format check
    func isDataValid(phoneNumber : String, userPassword : String) -> Bool {
        guard isValidPhone(number: phoneNumber) else {
            return false
        }
      
//        guard isValidPassword(password: userPassword) else {
//                        return false
//                    }
        return true
    }
    private let format = "SELF MATCHES %@"
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
