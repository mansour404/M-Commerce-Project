
//
//  ProductsModel.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 25/10/2023.
//

import Foundation

struct ProductsResponse: Codable {
    let products: [Product]
}

struct Product: Codable {
    let id: Int64
    let images: [Image]
    let variants: [Variant]
    let title : String
    
}
struct Variant: Codable {
    let id, product_id: Int64
    let title, price, sku: String

}

