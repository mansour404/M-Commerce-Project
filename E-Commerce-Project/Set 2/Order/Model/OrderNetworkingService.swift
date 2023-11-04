//
//  OrderNetworkingService.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 03/11/2023.
//

import Foundation
import Alamofire


class OrderNetworkingService {
    
    // service
    func getPriceRule <T:Codable> (Handler : @escaping (T?,Error?) -> Void){
        let URL = "https://a6cdf13b3aee85b07964a84ccc1bd762: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@ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/price_rules.json"
        AF.request(URL,method: .get).response { data in
            if let validData = data.data {
                do{
                    let dataRetivied = try JSONDecoder().decode(T.self, from: validData)
                    print("Success from get price rule network manager ")
                    Handler(dataRetivied, nil)
                    
                }catch let error{
                    print ("this is an error to fetch priceRules :\(error)")
                    Handler(nil, error)
                }
            }
            else{print("There is error in casting data")}
        }
    }
    
    
    func getSingleDiscountCode <T:Codable> (priceRuleId: Int,Handler : @escaping (T?,Error?) -> Void){
        let URL = "https://a6cdf13b3aee85b07964a84ccc1bd762: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@ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/price_rules/\(priceRuleId)/discount_codes.json"
        Alamofire.AF.request(URL,method: Alamofire.HTTPMethod.get).response { data in
            if let validData = data.data {
                do{
                    let dataRetivied = try JSONDecoder().decode(T.self, from: validData)
                    print("Success")
                    Handler(dataRetivied, nil)
                    
                }catch let error{
                    print ("this is an error :\(error)")
                    Handler(nil, error)
                }
            }
            else{print("There is error in casting data")}
        }
    }
    
}


struct AllPriceRules : Codable {
    let price_rules : [PriceRules]
}

struct PriceRules : Codable {
    let id : Int
    let title : String
    let value_type  : String
    let value : String
}

struct AllDiscounts : Codable {
    let discount_codes : [DiscountCodes]
}

struct DiscountCodes : Codable {
    let id : Int
    let price_rule_id : Int
    let code : String
    let usage_count : Int
    let created_at : String
    let updated_at : String
}
