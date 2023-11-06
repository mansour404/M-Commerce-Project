//
//  InventoryLevelResult.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 06/11/2023.
//

import Foundation


struct Inventory_level_result : Codable {
    let inventory_level : Inventory_level?

    enum CodingKeys: String, CodingKey {
        case inventory_level = "inventory_level"
    }
}


struct Inventory_level : Codable {
    let inventory_item_id : Int?
    let location_id : Int?
    let available : Int?
    let updated_at : String?
    let admin_graphql_api_id : String?

    enum CodingKeys: String, CodingKey {
        case inventory_item_id = "inventory_item_id"
        case location_id = "location_id"
        case available = "available"
        case updated_at = "updated_at"
        case admin_graphql_api_id = "admin_graphql_api_id"
    }
}

struct InventoryLevel: Codable{
    var inventoryItemId: Int?
    var locationId: Int?
    var available: Int?
    //var updatedAt: String?
    //var adminGraphqlApiId: String?

    private enum CodingKeys: String, CodingKey {
        case inventoryItemId = "inventory_item_id"
        case locationId = "location_id"
        case available = "available"
//        case updatedAt = "updated_at"
//        case adminGraphqlApiId = "admin_graphql_api_id"
    }
}
