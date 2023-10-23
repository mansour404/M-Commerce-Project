//
//  CurrencyViewModel.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 21/10/2023.
//

import Foundation

class CurrencyViewModel {
    
    // MARK: - Variables
    let exchnageRateService: ExchnageRateServiceProtocol
    var selectedCell: String?
    
    // MARK: - Proberties
    var currencyCodes: [String] = []
    var currencyValues: [Double] = []
    
//    var rate: Rates?
    
    // MARK: - Init
    init(exchnageRateService: ExchnageRateServiceProtocol = ExchnageRateService.shared) {
        self.exchnageRateService = exchnageRateService
    }
    
    // MARK: - Callback
    // callback for interface
    private var cellViewModels: [CurrencyCellViewModel] = [CurrencyCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var state: State = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    // MARK: - Closure
    // Three closure, Implement UI Changes in View By ViewModel object, when state is changed.
    var reloadTableViewClosure: (() -> ())?
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?

    
    func getCellViewModel( at indexPath: IndexPath ) -> CurrencyCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    // MARK: - Init fetch
    func initFetch() {
        state = .loading
        exchnageRateService.fetchData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                guard let rates = success?.rates else { return }
                var codes: [String] = []
                var values: [Double] = []
                codes.append(contentsOf: rates.keys)
                values.append(contentsOf: rates.values)
                
                self.processFetcheditems(codes, values)
                self.state = .populated
            case .failure(let error):
                self.state = .error
                print(error.localizedDescription)
            }
        }
    }
    
    func createCellViewModel(_ code: String, _ value: Double) -> CurrencyCellViewModel{
        
        // Mainpulate data before return it do what I wish before return.
        return CurrencyCellViewModel(currencyCode: code, currencyValue: value)
    }
    
    private func processFetcheditems(_ currencyCodes: [String], _ currencyValues: [Double]) {
        self.currencyCodes  = currencyCodes
        self.currencyValues = currencyValues
        var vms = [CurrencyCellViewModel]()  // vms enhance performance, reload tableView only once when vms filled
        for i in 0..<currencyCodes.count {
            vms.append(createCellViewModel(currencyCodes[i], currencyValues[i])) // return cellVM with same count of displayed cell, will save them temporally in vms to enhance performance, prevent reload table view for each cell.
        }
        cellViewModels = vms // cellViewModels has been changed, automatically table view will be reloaded.
        // cellViewModels will call the closure (reloadTableViewClosure?()), which implemented by viewController in initVM() function.
    }
    
}


extension CurrencyViewModel {
    func userPressed( at indexPath: IndexPath ){
        let item = self.currencyCodes[indexPath.row]
        selectedCell = item
        alertMessage = "OPOPOPOPOP"
    }
}
