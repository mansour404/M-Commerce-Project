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
