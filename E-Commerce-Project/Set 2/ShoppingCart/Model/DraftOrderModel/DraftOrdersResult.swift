//
//  DraftOrdersResult.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 28/10/2023.
//


import Foundation

struct ShoppingCartModel {
    //let id: Int
    let title: String?
    var quantity: Int?
    let price: Double?
    let image: String?
    let draftOrderId: Int?
    let variantId: Int?
    let availableElements: Int?
    let inventory_item_id: Int?
//    let product_id
}

class ShoppingCartList {
    static var items: [Line_items] = []
}


struct DraftOrdersResult : Codable {
    let draft_orders : [Draft_orders]?

    enum CodingKeys: String, CodingKey {
        case draft_orders = "draft_orders"
    }
}

struct Draft_orders : Codable {
	let id : Int?
    let note : String?
    let line_items : [Line_items]?
    let customer : CustomerTwo?
//	let order_id : Order_id?
//	let name : String?
//	let currency : String?
//	let subtotal_price : String?
//	let total_price : String?

	enum CodingKeys: String, CodingKey {
		case id = "id"
        case note = "note"
        case line_items = "line_items"
        case customer = "customer"
//		case order_id = "order_id"
//		case name = "name"
//		case currency = "currency"
//		case subtotal_price = "subtotal_price"
//		case total_price = "total_price"
	}
}

struct Line_items : Codable {
    let price : String?
    let quantity : Int?
    let title : String?
//    let id : Int?
//    let product_id : Int?
    let variant_id : Int?
//    let variant_title : String?
    let vendor : String?
//    let name : String?
//    let gift_card : Bool?
    
//    let applied_discount : String?
    let sku : String? // Hold image url string.
    let properties : [Properties]?
    
    enum CodingKeys: String, CodingKey {
        case price = "price"
        case quantity = "quantity"
        case title = "title"
//        case product_id = "product_id"
//        case id = "id"
        case variant_id = "variant_id"
//        case variant_title = "variant_title"
        case vendor = "vendor"
//        case name = "name"
//        case gift_card = "gift_card"
        case properties = "properties"
//        case applied_discount = "applied_discount"
        case sku = "sku"
    }
}

struct Properties : Codable {
    let name : String?
    let value : String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case value = "value"
    }
}

struct CustomerTwo : Codable {
    let id : Int?
    let email : String?
    let created_at : String?
    let updated_at : String?
    let first_name : String?
    let last_name : String?
    //let orders_count : String?
    let state : String?
    let total_spent : String?
    let last_order_id : Int?
    let verified_email : Bool?
    let multipass_identifier : String?
    let phone : String?
    let tags : String?
    let last_order_name : String?
    let currency : String?
    let addresses : Address?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case email = "email"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case first_name = "first_name"
        case last_name = "last_name"
        //case orders_count = "orders_count"
        case state = "state"
        case total_spent = "total_spent"
        case last_order_id = "last_order_id"
        case verified_email = "verified_email"
        case multipass_identifier = "multipass_identifier"
        case phone = "phone"
        case tags = "tags"
        case last_order_name = "last_order_name"
        case currency = "currency"
        case addresses = "addresses"
    }
}

struct Order_id : Codable {
    let id : Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}

struct Applied_discount : Codable {
    let description : String?
    let value : String?
    let title : String?
    let amount : String?
    let value_type : String?

    enum CodingKeys: String, CodingKey {
        case description = "description"
        case value = "value"
        case title = "title"
        case amount = "amount"
        case value_type = "value_type"
    }
}

