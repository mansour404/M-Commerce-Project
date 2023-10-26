//
//  AddressService.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 26/10/2023.
//

import Foundation
import Alamofire


class AddressService: AddressServiceProtocol {
    
//    private let stringUrl2 = "https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-01/customers/\(UserDefaultsHelper.shared.getCustomerId())/addresses.json"
//    let headers2: HTTPHeaders = [
//        "X-Shopify-Access-Token": "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",
//        "Content-Type": "application/json"
//    ]

    // MARK: - Creat new address
    func creatNewAddress(customerId: Int, address: Address, completion: @escaping (Result<[Address]?, Error>) -> Void) {
        let stringUrl = "https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-01/customers/\(customerId)/addresses.json"
        let firstName = address.firstName
        let lastName = address.lastName
        let name = "\(firstName ?? "firstName") " + "\(lastName ?? "lastName")"
        let city = address.city
        let country = address.country
        let phone = address.phone
        let address = address.address1
        
        let params: [String: Any] = ["customer_address":
                                        ["address1" : address, "name": name, "country": country, "city": city, "phone": phone, "first_name": firstName, "last_name": lastName, "country_name": country]
                                     
        ]
        let headers: HTTPHeaders = [
            "X-Shopify-Access-Token": "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",
            "Content-Type": "application/json"
        ]
        
        AF.request(stringUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseDecodable(of: CustomerAddresses.self) { response in
            switch response.result {
            case .success(let data):
                // Very important
                //print(String(data: address!, encoding: .utf8))
                completion(.success(data.addresses))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        //        AF.request(stringUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: head).response { response in
        //            switch response.result {
        //            case .success(let data):
        //                // Very important
        //                print(String(data: data!, encoding: .utf8))
        //            case .failure(let error):
        //                print(error.localizedDescription)
        //            }
        //        }
    }
    
    // MARK: - Get all addresses
    func getAllAddresses(customerId: Int, completion: @escaping (Result<[Address]?, Error>) -> Void) {
        let stringUrl = "https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-01/customers/\(customerId)/addresses.json"
        let headers: HTTPHeaders = [
            "X-Shopify-Access-Token": "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",
            "Content-Type": "application/json"
        ]
        
        AF.request(stringUrl, method: .get, encoding: URLEncoding.default, headers: headers).responseDecodable(of: CustomerAddresses.self) { response in
            switch response.result {
            case .success(let data):
                //print(String(data: address!, encoding: .utf8)) // Very important
                completion(.success(data.addresses))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Remove address
    func removeAddress(customerId: Int, address_id: Int, completion: @escaping (Result<Bool?, NSError>) -> Void) {
        let stringUrl = "https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/customers/\(customerId)/addresses/\(address_id).json"

        let head: HTTPHeaders = [
            "X-Shopify-Access-Token": "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",
            "Content-Type": "application/json"
        ]
        
        AF.request(stringUrl, method: .delete, headers: head).response { response in
            if response.response?.statusCode == 200 {
                print("true")
                completion(.success(true))
            } else {
                print("false")
                let error = NSError(domain: "remove user address domain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Generic error"])
                completion(.failure(error))
            }
        }
    }
    
    //    func getWishlist(forCustom customerID: Int, completion: @escaping (Result<[Product], Error>) -> Void) {
        //        fetchAllMetafields(forCustom: customerID) { result in
        //            switch result {
        //            case .success(let wishListMetafield):
        //                guard !wishListMetafield.isEmpty else {
        //                    completion(.success([]))
        //                    return
        //                }
        //                let stringIDs = wishListMetafield.compactMap( { String($0.key) }).joined(separator: ",")
        //                let url = self.baseURLString + "/products.json?ids=(stringIDs)"
        //                AF.request(url, method: .get, headers: self.header).responseDecodable(of: Products.self) { response in
        //                    switch response.result {
        //                    case .success(let data):
        //                        completion(.success(data.products))
        //                    case .failure(let error):
        //                        completion(.failure(error))
        //                    }
        //                }
        //            case .failure(let error):
        //                completion(.failure(error))
        //            }
        //        }
        //    }
}

/*
 /*
  "addresses": [
      {
        "id": 207119551,
        "customer_id": 6940095564,
        "first_name": "Bob",
        "last_name": "Norman",
        "company": null,
        "address1": "Chestnut Street 92",
        "address2": "Apartment 2",
        "city": "Louisville",
        "province": "Kentucky",
        "country": "United States",
        "zip": "40202",
        "phone": "555-625-1199",
        "province_code": "KY",
        "country_code": "US",
        "country_name": "United States",
        "default": true
      }
  */

 */
