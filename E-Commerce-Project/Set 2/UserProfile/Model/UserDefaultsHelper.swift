//
//  UserDefaultsHelper.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 24/10/2023.
//

import Foundation

final class UserDefaultsHelper {
    
    static let shared = UserDefaultsHelper()
    private init() {}
    
    func saveAPIToken(token: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(token, forKey: "token")
        //userDefaults.setValue(true, forKey: "isUserLoggedIn")
        setUserLogin()
        userDefaults.synchronize() // method is unnecessary and shouldn't be used.
        // restar app after saved token, restartApp() function.
    }
    
    func getAPIToken() -> String? {
        guard let token = UserDefaults.standard.object(forKey: "token") as? String else {
            return nil
        }
        return token
    }
    
    func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isUserLoggedIn")
    }
    
    func setUserLogin() {
        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
    }
    
    func setUserLogout() {
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
    }
    
    func checkIsUserLoggedIn(completion: @escaping (_ isLoggedIn: Bool) -> Void){
        if isUserLoggedIn() {
            completion(true)
        }else{
            completion(false)
        }
    }
}
