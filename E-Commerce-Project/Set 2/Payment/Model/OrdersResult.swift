//
//  OrdersResult.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 31/10/2023.
//

import Foundation

/*
 {
     "order": {
         "line_items": [
             {
                 "title": "Big Brown Bear Boots",
                 "price": 150.00,
                 "grams": "500",
                 "quantity": 2
             },
             {
                 "title": "Big Brown Bear Boots",
                 "price": 100.00,
                 "grams": "1000",
                 "quantity": 3
             },
             {
                 "title": "Big Brown Bear Boots",
                 "price": 300.00,
                 "grams": "200",
                 "quantity": 1
             }
         ],
         "transactions": [
             {
                 "kind": "sale",
                 "status": "success",
                 "amount": 900.00
             }
         ],
         "total_tax": 0,
         "currency": "EUR",
         "phone": "+201063464493",
         "location_id": 8159536349334,
         "shipping_address": {
             "address1": "jjjj",
             "city": "eewe",
             "first_name": "trtrtr",
             "last_name": "uuuuioo",
             "phone": "999",
             "country": "Egypt",
             "name": "khater kahater4",
             "country_name": "Egypt"
         }
     }
 }
 */

struct OrderNewModel : Codable {
    let total_tax: String?
    let currency: String?
    let phone: String? // "+201063464493",
    let total_discounts: String?
    let user_id : String?
    let line_items : [Line_items]?
    let shipping_address : Shipping_address? // don't forget to set shipping address.
}

struct OrdersResultNewModel : Codable {
    let order : OrderNewModel?
}

struct OrdersResult : Codable {
    let orders : [Orders]?
    enum CodingKeys: String, CodingKey {
        case orders = "orders"
    }
}

struct Orders : Codable {
    let id : Int?
    let created_at : String?
    let currency : String?
    let email : String?
    let name : String?
    let order_number : Int?
    let order_status_url : String?
    let total_price : String?
    let total_discounts: String?
    let user_id : String?
    let line_items : [Line_items]?
    let shipping_address : Shipping_address?
    let shipping_lines : [String]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case created_at = "created_at"
        case currency = "currency"
        case email = "email"
        case name = "name"
        case order_number = "order_numb"
        case order_status_url = "order_status_url"
        case total_price = "total_price"
        case total_discounts = "total_discounts"
        case user_id = "user_id"
        case line_items = "line_items"
        case shipping_address = "shipping_address"
        case shipping_lines = "shipping_lines"
    }
}

/*
 Difference between Shipping_address and Address, Address has more attribute.
let id : Int?
let customerId : Int?
let isDefault : Bool?
 */

struct Shipping_address : Codable {
    let first_name : String?
    let address1 : String?
    let phone : String?
    let city : String?
    let country : String?
    let last_name : String?
    let address2 : String?
    let company : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case first_name = "first_name"
        case address1 = "address1"
        case phone = "phone"
        case city = "city"
        case country = "country"
        case last_name = "last_name"
        case address2 = "address2"
        case company = "company"
        case name = "name"
    }
}

struct Default_address : Codable {
    let id : Int?
    let customer_id : Int?
    let first_name : String?
    let address1 : String?
    let phone : String?
    let city : String?
    let country : String?
    let last_name : String?
    let address2 : String?
    let company : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case customer_id = "customer_id"
        case first_name = "first_name"
        case address1 = "address1"
        case phone = "phone"
        case city = "city"
        case country = "country"
        case last_name = "last_name"
        case address2 = "address2"
        case company = "company"
        case name = "name"
    }
}
