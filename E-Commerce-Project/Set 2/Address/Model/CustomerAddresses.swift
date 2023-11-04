//
//  CustomerAddresses.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 25/10/2023.
//

import Foundation

struct CustomerAddresses : Codable {
	let addresses : [Address]?

	enum CodingKeys: String, CodingKey {

		case addresses = "addresses"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		addresses = try values.decodeIfPresent([Address].self, forKey: .addresses)
	}

}


struct Address : Codable {
    let id : Int?
    let customerId : Int?
    let firstName : String?
    let lastName : String?
    let name : String?
    let address1 : String?
    let address2 : String?
    let city : String?
    let country : String?
    let phone : String?
    let isDefault : Bool?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case customerId = "customer_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case name = "name"
        case address1 = "address1"
        case address2 = "address2"
        case city = "city"
        case country = "country"
        case phone = "phone"
        case isDefault = "default"
    }
}
