//
//  HomeModel.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 23/10/2023.
//

import Foundation

struct Brands : Codable{
    let smart_collections : [SmartCollectionModel]
}

struct SmartCollectionModel: Codable {
    let title: String
    let id : Int
    let image: Image
}

struct Image: Codable {
    let src: String
}

               /*------------------------------------------*/

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



