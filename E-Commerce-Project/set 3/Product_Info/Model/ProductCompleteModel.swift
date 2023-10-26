//
//  ProductCompleteModel.swift
//  E-Commerce-Project
//
//  Created by Admin on 25/10/2023.
//

import Foundation


struct VariantCompleteModel : Codable {
    var  price : String?
    var option1 : String?
    var option2 : String?
    var option3 : String?
    var inventory_quantity : Int?
}
struct OptionCompleteModel : Codable {
    var name : String?
    var position : Int?
    var values : [String]?
}

struct AllProducts : Codable {
    var product : ProductCompleteModel?
}

struct ProductCompleteModel : Codable {
    var id : Int?
    var title : String?
    var vendor : String?
    var body_html : String?
    var images : [Image]
    var variants : [VariantCompleteModel]?
    var options : [OptionCompleteModel]?
    var tags : String?
}
struct ProductImageCompleteModel : Codable {
    var id : Int?
    var src : String?
}
