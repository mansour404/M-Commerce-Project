//
//  LoginViewModel.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 25/10/2023.
//

import Foundation

class LoginViewModel {
    var handerDataOfHome: (() -> Void)?
    var  bindresultToProductsViewController: ( () -> () ) = {}
  
    var services = NetworkServices()
    
    var AllCustomers: CustomerList? {
        didSet{
            if let validHander =  handerDataOfHome {
                validHander()
            }
        }
    }
    //MARK: -CAll Request of Api
    func getDataFromApiForProduct() {
        services.getCustomerData(Handler: { (dataValue:CustomerList?, error: Error?) in
            print("Success")

            if let mydata = dataValue {
                self.AllCustomers = mydata
                self.bindresultToProductsViewController()

            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
    }
    
    //MARK: -check if customer exist in Api
//    func checkCustomerInfo(userName : String , userPassword : String) -> Bool {
//        for i in 0...(AllCustomers?.customers.count)! {
//            if (AllCustomers?.customers[i].first_name)
//        }
//    }
}

