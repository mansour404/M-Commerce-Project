//
//  AddressNetworking.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 25/10/2023.
//

import Foundation
import Alamofire

enum AddressNetworking {
    case getListOfAddresses(customerId: Int)
    // case creatNewAddress(customerId: String, firstName: String, lastName: String, country: String, city: String, address: String, phoneNumber: Int, isDefault: Bool = false)
    case creatNewAddress(customerId: Int, address: Address)
    case removeAddress(customerId: Int, addressId: Int)
}

extension AddressNetworking: TargetType {
    var baseURL: String {
        return URLs.base
    }
    
    var pathURL: String {
        //static let addressPath = "customers/\(UserDefault().getUserId())/addresses.json"
        switch self {
        case .getListOfAddresses:
            return ""
        case .creatNewAddress:
            return URLs.addressPath
        case .removeAddress:
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getListOfAddresses:
            return .get
        case .creatNewAddress:
            return .post
        case .removeAddress:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .getListOfAddresses:
            return .requestPlain
        case .creatNewAddress(_, let address):
            let firstName = address.firstName
            let lastName = address.lastName
            let name = "\(firstName ?? "OO") " + "\(lastName ?? "OO")"
            let city = address.city
            let country = address.country
            let phone = address.phone
            let address = address.address1
            let params: [String: Any] = ["customer_address":
                                            [
                                                "address1" : address, "address2": address, "name": name, "country": country, "city": city, "phone": phone, "first_name":firstName, "last_name": lastName, "country_name": country
                                            ]
                                         ]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .removeAddress:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [
            "X-Shopify-Access-Token": "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"
            //"Content-Type": "application/json"
        ]
    }
}
