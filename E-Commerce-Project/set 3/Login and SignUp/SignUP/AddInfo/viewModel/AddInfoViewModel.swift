//
//  AddInfoViewModel.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 03/11/2023.
//

import Foundation
class AddInfoViewModel {
    
    //MARK: - get data from api
    //MARK: - edit customer information in API
    //MARK: - Authoentication  data format check
    func isDataValid(phoneNumber : String, userPassword : String) -> Bool {
        guard isValidPhone(number: phoneNumber) else {
            return false
        }
      
        guard isValidPassword(password: userPassword) else {
                        return false
                    }
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
