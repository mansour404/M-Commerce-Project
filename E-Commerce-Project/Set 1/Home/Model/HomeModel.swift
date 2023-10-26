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
