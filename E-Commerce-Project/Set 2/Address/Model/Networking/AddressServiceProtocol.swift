//
//  AddressServiceProtocol.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 26/10/2023.
//

import Foundation

protocol AddressServiceProtocol {
    func creatNewAddress(customerId: Int, address: Address, completion: @escaping (Result<[Address]?, Error>) -> Void)
    func getAllAddresses(customerId: Int, completion: @escaping (Result<[Address]?, Error>) -> Void)
    func removeAddress(customerId: Int, address_id: Int, completion: @escaping (Result<Bool?, NSError>) -> Void)
    func getSingleAddress(customerId: Int, address_id: Int, completion: @escaping (Result<Address?, Error>) -> Void)
}
