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
    
    func postInventoryLevelForProduct(parameters: Parameters, completion: @escaping (Error?) -> Void) {
        let stringUrl = "https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/inventory_levels/set.json"
        AF.request( stringUrl,method: .post,parameters: parameters, encoding: JSONEncoding.default, headers: headers).response
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

