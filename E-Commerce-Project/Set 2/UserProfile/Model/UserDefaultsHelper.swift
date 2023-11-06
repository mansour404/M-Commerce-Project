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
//        userDefaults.setValue(id, forKey: "id")
        userDefaults.setValue(id, forKey: "customerId")
        //userDefaults.setValue(true, forKey: "isUserLoggedIn")
        setCustomerLogin()
        userDefaults.synchronize() // method is unnecessary and shouldn't be used.
        // restar app after saved token, restartApp() function.
    }
    
    func saveCustomerEmail(customerName: String) {
        userDefaults.setValue(customerName, forKey: "customerEmail")
        //userDefaults.setValue(true, forKey: "isUserLoggedIn")
        setCustomerLogin()
        userDefaults.synchronize() // method is unnecessary and shouldn't be used.
        // restar app after saved token, restartApp() function.
    }
  
    
    
    func getAPIToken() -> String? {
//        guard let token = userDefaults.object(forKey: "id") as? String else {
        guard let token = userDefaults.object(forKey: "customerId") as? String else {
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
        return userDefaults.integer(forKey: "customerId")
        //return 6866630049942
        // 6866434621590
    }
    
    // set static userId
    func setCustomerId(_ customerID: Int) {
        userDefaults.set(customerID, forKey: "customerId")
        setCustomerLogin()
    }
    
    func deleteCustomerId() {
        userDefaults.set(-1, forKey: "customerId")
        setCustomerLogout()
    }
    
    func setCartId() {
        userDefaults.set(2023, forKey: "cartId")
    }
    
    func getCartId() -> Int {
        userDefaults.integer(forKey: "cartId")
    }
        
    func setFinalTotalCost(_ value: Double) {
        userDefaults.set(value, forKey: "finalTotalCost")
    }
    
    func getFinalTotalCost() -> Double {
        userDefaults.double(forKey: "finalTotalCost")
    }
    
    func setInventoryLocationId() {
        userDefaults.set(67733225622, forKey: "inventoryLocationId") // yousof added static value for inventory location.
    }
    
    func getInventoryLocationId() {
        userDefaults.integer(forKey: "inventoryLocationId")
    }
    
    
    func getCurrencySymbol() -> String {
        userDefaults.string(forKey: "currencySymbol") ?? "USD" // if not set currency symbol
    }
    
    func getCurrencyRate() -> Double {
        if userDefaults.double(forKey: "currencyRate") == 0 { // if not set currency rate
            return 1.0
        }
        return userDefaults.double(forKey: "currencyRate")
    }
    
    func setCurrencySymbol(_ value: String) {
        userDefaults.set(value, forKey: "currencySymbol")
    }
    
    func setCurrencyRate(_ value: Double) {
        userDefaults.set(value, forKey: "currencyRate")
    }
    
    func setContinueToPayment(_ value: Bool) {
        userDefaults.set(value, forKey: "continueToPatment")
    }
    
    func getContinueToPayment() -> Bool? {
        userDefaults.bool(forKey: "continueToPatment")
    }
    
}

class CurrencyManager {
    class func returnPriceAndSymbol(price: String) -> (String, String) {
        let doublePrice = (price as NSString).doubleValue
        let currency = UserDefaultsHelper.shared.getCurrencyRate()
        let symbol = UserDefaultsHelper.shared.getCurrencySymbol()
        let roundedCost = Double(String(format:"%.2f", (doublePrice * currency))) ?? 1.00
        return (String(roundedCost), symbol)
    }
}
