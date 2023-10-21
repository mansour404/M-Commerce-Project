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
    private var cellViewModels: [CurrencyCellViewModel] = [CurrencyCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    
    
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
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    // MARK: - Closure
    // One closure, Implement UI Changes in View By ViewModel object
    var reloadTableViewClosure: (() -> ())?
    var showAlertClosure: (() -> ())?

    
    func getCellViewModel( at indexPath: IndexPath ) -> CurrencyCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    // MARK: - Init fetch
    func initFetch() {
        exchnageRateService.fetchData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                guard let rates = success?.rates else { return }
                var codes: [String] = []
                var values: [Double] = []
                codes.append(contentsOf: rates.keys)
                values.append(contentsOf: rates.values)
                print(codes.count)
                print(values.count)
                self.processFetcheditems(codes, values)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func createCellViewModel(_ code: String, _ value: Double) -> CurrencyCellViewModel{
        return CurrencyCellViewModel(currencyCode: code, currencyValue: value)
    }
    
    private func processFetcheditems(_ currencyCodes: [String], _ currencyValues: [Double]) {
        self.currencyCodes  = currencyCodes
        self.currencyValues = currencyValues
        var vms = [CurrencyCellViewModel]()
        for i in 0..<currencyCodes.count {
            vms.append(createCellViewModel(currencyCodes[i], currencyValues[i]))
        }
        cellViewModels = vms
    }
    
}


extension CurrencyViewModel {
    func userPressed( at indexPath: IndexPath ){
        let item = self.currencyCodes[indexPath.row]
        selectedCell = item
        alertMessage = "OPOPOPOPOP"
    }
}
