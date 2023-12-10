//
//  CustomerModel.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 25/10/2023.
//

import Foundation
struct CustomerList : Codable {
    var  customers : [Customer]
}
struct Customer : Codable {
    var id : Int?
    var email : String?
    var first_name : String?
    var last_name : String?
    var phone : String?
    var tags : String?
    var addresses : [Adress]
}
struct Adress : Codable {
    var id : Int?
    var first_name : String?
    var last_name : String?
    var address1 : String?
    var address2 : String?
    var country_code : String?
    var zip : String?
    var city : String?
    var country_name : String?
}

