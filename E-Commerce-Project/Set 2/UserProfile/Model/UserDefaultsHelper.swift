//
//  UserDefaultsHelper.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 24/10/2023.
//

import Foundation

final class UserDefaultsHelper {
    
    static let shared = UserDefaultsHelper()
    private let userDefaults = UserDefaults.standard
    private init() {}
    
    func saveAPI(id: Int) {
        userDefaults.setValue(id, forKey: "id")
        //userDefaults.setValue(true, forKey: "isUserLoggedIn")
        setCustomerLogin()
        userDefaults.synchronize() // method is unnecessary and shouldn't be used.
        // restar app after saved token, restartApp() function.
    }
    
    
    func getAPIToken() -> String? {
        guard let token = userDefaults.object(forKey: "id") as? String else {
            return nil
        }
        return token
    }
    
    func isUserLoggedIn() -> Bool {
        return userDefaults.bool(forKey: "isCustomerLoggedIn")
    }
    
    func setCustomerLogin() {
        userDefaults.set(true, forKey: "isCustomerLoggedIn")
    }
    
    func setCustomerLogout() {
        userDefaults.set(false, forKey: "isCustomerLoggedIn")
    }
    
    func checkIsCustomerLoggedIn(completion: @escaping (_ isLoggedIn: Bool) -> Void){
        if isUserLoggedIn() {
            completion(true)
        }else{
            completion(false)
        }
    }
    
    func getCustomerId() -> Int {
        return userDefaults.integer(forKey: " ")
        //return 6866630049942
    }
    
    // set static userId
    func setCustomerId(Id : Int?) {
        userDefaults.set( 6866630049942, forKey: "customerId")
        setCustomerLogin()
    }
    
    func deleteCustomerId() {
        userDefaults.set(-1, forKey: "customerId")
    }
}
