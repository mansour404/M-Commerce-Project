//
//  WhislistModel.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 25/10/2023.
//

import Foundation
struct WhishList : Codable {
    let metafields : [FavouriteProduct]
}
struct FavouriteProduct : Codable{
    var id : Int?
    var key : String?          // product Id
    var value : String?     // product Name
    var owner_id : Int?     // customer Id
    var namespace : String?
    var description : String?
    var created_at : String?
    var updated_at : String?
    var owner_resource : String?
    var type : String?
}








