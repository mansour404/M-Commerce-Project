
//
//  ProductsModel.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 25/10/2023.
//

import Foundation

struct ProductsResponse: Codable {
    var products: [Product]
}

struct Variant : Codable {
    var  price : String?
    var option1 : String?
    var option2 : String?
    var option3 : String?
}
struct Product : Codable {
    var id : Int64?
    var title : String?
    var vendor : String?
    var body_html : String?
    var images : [Image]
    var variants : [Variant]?
    var tags : String?
}

