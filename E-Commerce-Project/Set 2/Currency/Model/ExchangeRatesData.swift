//
//  ExchangeRates.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 21/10/2023.
//

import Foundation


struct ExchangeRatesData : Decodable {
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
    let rates: Rates?
//    let rates : [String: Double]?

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
}

struct Rates : Codable {
    let USD : Double?
    let EGP : Double?
    let SAR : Double?
    let AED : Double?
    let KWD : Double?
    let QAR : Double?
    
    enum CodingKeys: String, CodingKey {
        case USD = "USD"
        case EGP = "EGP"
        case SAR = "SAR"
        case AED = "AED"
        case KWD = "KWD"
        case QAR = "QAR"
    }
}

struct AppSupportedCurrency {
    let title: String
    let valueToDollar: Double?
}

//struct Currency: Codable {
//    let currency: String?
//    let rateUpdatedAt: String?
//    let enabled: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case currency = "currency"
//        case rateUpdatedAt = "rate_updated_at"
//        case enabled = "enabled"
//    }
//}
