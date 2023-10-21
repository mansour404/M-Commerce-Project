//
//  SettingViewModel.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 21/10/2023.
//

import Foundation

class SettingViewModel {
        
    // MARK: - Variables
    private var items: [SettingModel] = [SettingModel]()
    private var cellViewModels: [SettingCellViewModel] = [SettingCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var selectedItem: SettingModel?

    
    // MARK: - Callback
    // callback for interfaces
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    // MARK: - Closure
    // One closure, Implement UI Changes in View By ViewModel object
    var reloadTableViewClosure: (() -> ())?
    
    
    func getCellViewModel( at indexPath: IndexPath ) -> SettingCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    // MARK: - Init fetch
    func initFetch() {
        let items = SettingModel.fetchSettings()
        processFetchedItems(items)
    }
    
    func createCellViewModel( item: SettingModel ) -> SettingCellViewModel {
        //Wrap a description
        var descTextContainer: [String] = [String]()
        if let title = item.title {
            descTextContainer.append(title)
        }
        
        //return SettingCellViewModel(titleText: item.title)
        return SettingCellViewModel(titleText: item.title ?? "Mansour")
    }
    
    private func processFetchedItems(_ items: [SettingModel]) {
        self.items = items
        var vms = [SettingCellViewModel]()
        for item in items {
            vms.append(createCellViewModel(item: item))
        }
        cellViewModels = vms
    }

}


extension SettingViewModel {
    func userPressed( at indexPath: IndexPath ){
        let item = self.items[indexPath.row]
        selectedItem = item
    }
}
