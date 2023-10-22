//
//  ExchangeRates.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 21/10/2023.
//

import Foundation


struct ExchangeRates : Codable {
	let result : String?
	let provider : String?
	let documentation : String?
	let terms_of_use : String?
	let time_last_update_unix : Int?
	let time_last_update_utc : String?
	let time_next_update_unix : Int?
	let time_next_update_utc : String?
	let time_eol_unix : Int?
	let base_code : String?
	let rates : Rates?

	enum CodingKeys: String, CodingKey {

		case result = "result"
		case provider = "provider"
		case documentation = "documentation"
		case terms_of_use = "terms_of_use"
		case time_last_update_unix = "time_last_update_unix"
		case time_last_update_utc = "time_last_update_utc"
		case time_next_update_unix = "time_next_update_unix"
		case time_next_update_utc = "time_next_update_utc"
		case time_eol_unix = "time_eol_unix"
		case base_code = "base_code"
		case rates = "rates"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		result = try values.decodeIfPresent(String.self, forKey: .result)
		provider = try values.decodeIfPresent(String.self, forKey: .provider)
		documentation = try values.decodeIfPresent(String.self, forKey: .documentation)
		terms_of_use = try values.decodeIfPresent(String.self, forKey: .terms_of_use)
		time_last_update_unix = try values.decodeIfPresent(Int.self, forKey: .time_last_update_unix)
		time_last_update_utc = try values.decodeIfPresent(String.self, forKey: .time_last_update_utc)
		time_next_update_unix = try values.decodeIfPresent(Int.self, forKey: .time_next_update_unix)
		time_next_update_utc = try values.decodeIfPresent(String.self, forKey: .time_next_update_utc)
		time_eol_unix = try values.decodeIfPresent(Int.self, forKey: .time_eol_unix)
		base_code = try values.decodeIfPresent(String.self, forKey: .base_code)
		rates = try values.decodeIfPresent(Rates.self, forKey: .rates)
	}

}
