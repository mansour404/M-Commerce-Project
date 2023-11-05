//
//  userOrderModel.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 25/10/2023.
//

import Foundation

struct AllOrders : Codable {
    let orders : [UserOrders]?
}

struct UserOrders : Codable {
    let id : Int?  //5370903756950
    let shipping_address : CustomerOrder?
    let order_number : Int?
    let total_price : String?
    let line_items : [Items]?
}

struct CustomerOrder : Codable {
    let name : String
    let phone : String
    let address1 : String
}

struct Items : Codable {
    let quantity : Int
    let title : String
}


