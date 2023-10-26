//
//  WhislistModel.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 25/10/2023.
//

import Foundation
struct WhishList : Codable {
    var metafields : [FavouriteProduct]
}
struct FavouriteProduct : Codable{
    var id : Int64?
    var key : String?          // product Id
    var value : String?     // product Name
    var owner_id : Int64?     // customer Id
}
