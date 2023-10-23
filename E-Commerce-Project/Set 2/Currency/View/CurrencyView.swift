//
//  CurrencyView.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 21/10/2023.
//

import UIKit

class CurrencyView: UIViewController {
    
    // MARK: - Vars
    lazy var viewModel: CurrencyViewModel = {
        return CurrencyViewModel()
    }()
    
    var rates: [String: Double]? = [:]
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationItem()
        
        // init view model
        initVM()
    }
    
}


// MARK: - Data source
extension CurrencyView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.numberOfCells)
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as? CurrencyCell else { return UITableViewCell() }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.currencyCellViewModel = cellVM
        return cell
    }
}

// MARK: - Delegate
extension CurrencyView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //showCurrencyAlert()
        //viewModel.userPressed(at: indexPath)
    }
}

// MARK: - Configure View
extension CurrencyView {
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        // Register cell
        let nib = UINib(nibName: "CurrencyCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CurrencyCell")
    }
    
    private func configureNavigationItem() {
        self.navigationItem.title = "Currency"
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
//    private func showCurrencyAlert(_ msg: String = "you are going to change payment currency") {
//        let alert = showAlert(title: "Change currency", msg: msg) { action in
//            print("SIIIIIIIIII")
//            self.dismiss(animated: true)
//        }
//        self.present(alert, animated: true)
//    }
}

// MARK: - Binding
extension CurrencyView {
    func initVM() {
        
        // MARK: Naive binding: Set the 3 closure implementation
        
        // 1
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert(message)
                }
            }
        }
        
        // 2
        viewModel.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        // 3
        viewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch self.viewModel.state {
                case .empty, .error:
                    self.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.tableView.alpha = 0.0
                    })
                case .loading:
                    self.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.tableView.alpha = 0.0
                    })
                case .populated:
                    self.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.tableView.alpha = 1.0
                    })
                }
            }
        }
        
        // Finally
        viewModel.initFetch()
    }
    
//    func alertClosure() {
//        viewModel.showAlertClosure = { [weak self] in
//            DispatchQueue.main.async {
//                if let message = self?.viewModel.alertMessage {
//                    self?.showCurrencyAlert(message)
//                }
//            }
//        }
//    }
}
