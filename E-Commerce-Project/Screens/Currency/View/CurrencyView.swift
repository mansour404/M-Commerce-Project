//
//  CurrencyView.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 21/10/2023.
//

import UIKit

class CurrencyView: UIViewController {
    
    var rates: [String: Double]? = [:]
    var items: ExchangeRates?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ExchnageRateManager.shared.fetchData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                //rates = success?.rates
                items = success
                print(items?.rates ?? "No rates")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
       
        
    }


}
