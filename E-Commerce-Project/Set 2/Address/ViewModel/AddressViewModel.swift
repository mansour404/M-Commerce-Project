//
//  AddressViewModel.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 25/10/2023.
//

import Foundation
import Alamofire

protocol AddressViewModelProtocol {
    
}

class AddressViewModel {
    // MARK: - Variables
    var addressService: AddressServiceProtocol!
    var items: [Address] = []
    var newAddress: [Address] = []
    var shippingAddress: Address?
    let customerId: Int = UserDefaultsHelper.shared.getCustomerId()
    
    // MARK: - Init
    init(addressService: AddressServiceProtocol = AddressService()) {
        self.addressService = addressService
    }
   
    // MARK: - Callback
    // callback for interface

    private var cellViewModels: [AddressCellViewModel] = [AddressCellViewModel]() {
        didSet {
            self.reloadAddressTableViewClosure?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    // MARK: - Closure
    // closure, Implement UI Changes in View By ViewModel object, when state is changed.
    var reloadAddressTableViewClosure: (() -> ())?
    
    
    // MARK: - Address list view
    func getCellViewModel( at indexPath: IndexPath ) -> AddressCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel(name: String, city: String, address: String, isDefault: Bool) -> AddressCellViewModel{
        
        // Mainpulate data before return it do what I wish before return.
        return AddressCellViewModel(name: name, city: city, address: address, isDefault: isDefault)
    }
    
    private func processFetcheditems(_ items: [Address]) {
        self.items  = items
        var vms = [AddressCellViewModel]()  // vms enhance performance, reload tableView only once when vms filled
        for i in 0..<items.count {
            let address = items[i]
            vms.append(createCellViewModel(name: address.name!, city: address.city!, address: address.address1!, isDefault: address.isDefault!)) // return cellVM with same count of displayed cell, will save them temporally in vms to enhance performance, prevent reload table view for each cell.
        }
        cellViewModels = vms // cellViewModels has been changed, automatically table view will be reloaded.
        // cellViewModels will call the closure (reloadTableViewClosure?()), which implemented by viewController in initVM() function.
    }
    
    
    
    // MARK: - API functions
    func creatNewAddress(address: Address){
        addressService.creatNewAddress(customerId: customerId, address: address) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let data = data else { return }
                print(data.count)
                //newAddress = data
                self.items.append(contentsOf: data)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func getAllAddresses() {
        addressService.getAllAddresses(customerId: customerId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let addresses = data else { return }
                self.items = addresses // Cashing
                self.processFetcheditems(items)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func removeAddress(indexPath: IndexPath) {
        guard let address_id = items[indexPath.row].id else { return }
        addressService.removeAddress(customerId: customerId, address_id: address_id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                print(success as Any)
                self.items.remove(at: indexPath.row)
                self.processFetcheditems(self.items)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    
    func selectAddressForShipping(indexPath: IndexPath) {
        guard let address_id = items[indexPath.row].id else { return }
        addressService.getSingleAddress(customerId: customerId, address_id: address_id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let address):
                print("success")
                self.shippingAddress = address
                //completion(.success(success))
            case .failure(let error):
                print(error)
                //completion(.failure(error))
            }
        }
    }
  
}
