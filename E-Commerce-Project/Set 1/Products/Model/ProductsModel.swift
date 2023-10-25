//
//  ProductsModel.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 25/10/2023.
//

import Foundation
struct ProductsList : Codable {
    var products : [Product]
}
struct Variant : Codable {
    var  price : String?
    var option1 : String?
    var option2 : String?
    var option3 : String?
}
struct Product : Codable {
    var id : Int?
    var title : String?
    var vendor : String?
    var body_html : String?
    var images : [ProductImage]
    var variant : [Variant]?
}
struct ProductImage : Codable {
    var id : Int?
    var src : String?
}

