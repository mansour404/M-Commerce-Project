//
//  CurrencyViewModel.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 21/10/2023.
//

import Foundation

protocol CurrencyViewModelProtocol {
    
}


class CurrencyViewModel {
    
    // MARK: - Variables
    let exchnageRateService: ExchnageRateServiceProtocol
    var selectedCell: String?
    var chosenIndex: Int?
    
    // MARK: - Properties
    var currencies = [AppSupportedCurrency]()

    // MARK: - Init
    init(exchnageRateService: ExchnageRateServiceProtocol = ExchnageRateService()) {
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

    
    func getCellViewModel(at indexPath: IndexPath) -> CurrencyCellViewModel {
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

                let myStrings = [ "USD", "EGP", "SAR",  "AED", "KWD", "QAR"]
                let objectOne = AppSupportedCurrency(title: myStrings[0], valueToDollar: rates.USD)
                let objectTwo = AppSupportedCurrency(title: myStrings[1], valueToDollar: rates.EGP)
                let objectThree = AppSupportedCurrency(title: myStrings[2], valueToDollar: rates.SAR)
                let objectFour = AppSupportedCurrency(title: myStrings[3], valueToDollar: rates.AED)
                let objectFive = AppSupportedCurrency(title: myStrings[4], valueToDollar: rates.KWD)
                let objectSix = AppSupportedCurrency(title: myStrings[5], valueToDollar: rates.QAR)
                let arr = [objectOne, objectTwo, objectThree, objectFour, objectFive, objectSix]
                
                //self.currencies = arr // set the value inside processFetcheditems() function
                self.processFetcheditems(arr)
                self.state = .populated
            case .failure(let error):
                self.state = .error
                print(error.localizedDescription)
            }
        }
    }
    
    private func createCellViewModel(_ currency: AppSupportedCurrency) -> CurrencyCellViewModel{
        // Mainpulate data before return it do what I wish before return.
        return CurrencyCellViewModel(currencyCode: currency.title, currencyValue: currency.valueToDollar)
    }
    
    private func processFetcheditems(_ currencies: [AppSupportedCurrency]) {
        self.currencies = currencies
        var vms = [CurrencyCellViewModel]()  // vms enhance performance, reload tableView only once when vms filled
        
        for currency in currencies {
            vms.append(createCellViewModel(currency)) // return cellVM with same count of displayed cell, will save them temporally in vms to enhance performance, prevent reload table view for each cell.
        }
        cellViewModels = vms // cellViewModels has been changed, automatically table view will be reloaded.
        // cellViewModels will call the closure (reloadTableViewClosure?()), which implemented by viewController in initVM() function.
    }
    
    
}


extension CurrencyViewModel {
    
    func userPressed( at indexPath: IndexPath ){
        let item = currencies[indexPath.row]
        alertMessage = "would you like to confirm the app currency change to \"" + item.title + "\" ?"
        chosenIndex = indexPath.row
    }
    
    func changeAppCurrency() {
        guard let chosenIndex = chosenIndex else { return }
        let symbol = currencies[chosenIndex].title
        let rate = currencies[chosenIndex].valueToDollar ?? 1.0
        
        UserDefaultsHelper.shared.setCurrencySymbol(symbol)
        UserDefaultsHelper.shared.setCurrencyRate(rate)
        
        print("++++++++++++++++++++++++++")
        print(UserDefaultsHelper.shared.getCurrencyRate())
        print(UserDefaultsHelper.shared.getCurrencySymbol())
        print("++++++++++++++++++++++++++")
    }
 
}
