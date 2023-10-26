//
//  AddressAPI.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 25/10/2023.
//

import Foundation

protocol AddressAPIProtocol {
    func creatNewAddress(customerId: Int, address: Address, completion: @escaping (Result<CustomerAddresses?, NSError>) -> Void)
}

class AddressAPI: BaseAPI<AddressNetworking>, AddressAPIProtocol {

    func creatNewAddress(customerId: Int, address: Address, completion: @escaping (Result<CustomerAddresses?, NSError>) -> Void) {
        fetchData(target: .creatNewAddress(customerId: customerId, address: address), model: CustomerAddresses.self) { result in
            switch result {
            case .success(let value):
                print("YEEEEEEEEEEEESSSSS!!!!!")
                print (value?.addresses?.first?.phone ?? "### ### ### ###" )
                completion(.success(value))
            case .failure(let error):
                print("NOOOOOOOOOOOOOOOO!!!!!")
                completion(.failure(error))
            }
        }
    }
    
    
}
