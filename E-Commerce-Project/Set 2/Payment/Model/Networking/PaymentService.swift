//
//  PaymentService.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 01/11/2023.
//

import Foundation
import Alamofire

class PaymentService {
    let headers: HTTPHeaders = [
        "X-Shopify-Access-Token": "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",
        "Content-Type": "application/json"
    ]
    
    func postInventoryLevelForProduct(inventory_item_id: Int, available_adjustment: Int, completion: @escaping (Error?) -> Void) {
        
        // There is difference between /set.json & /adjust.json
        // set: set the new value
        // adjust: i will send the order quantity in negative value and he will update the available quantity automatically.
        //let stringUrl = "https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/inventory_levels/set.json"
        let stringUrl = "https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/inventory_levels/adjust.json"
        
        let parameters = [
                "location_id": 67733225622, // constatnt.
                "inventory_item_id": inventory_item_id,
                "available_adjustment": available_adjustment // must be negative.
        ]
        AF.request( stringUrl,method: .post,parameters: parameters,encoding: JSONEncoding.default, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                print(String(data: data!, encoding: .utf8))
                completion(nil)
            case .failure(let error):
                print(error)
                completion(error)
            }
        }
    }
    
    func postOrder(parameters: Parameters, completion: @escaping (Error?) -> Void) {
        let stringUrl = "https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/orders.json"
        
        AF.request( stringUrl,method: .post,parameters: parameters, encoding: JSONEncoding.default, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                print(String(data: data!, encoding: .utf8))
                completion(nil)
            case .failure(let error):
                print(error)
                completion(error)
            }
        }
    }
    
}

