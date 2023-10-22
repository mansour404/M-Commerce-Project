//
//  SettingsView.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 21/10/2023.
//

import UIKit

class SettingsView: UIViewController {
    
    // MARK: - Vars
    lazy var viewModel: SettingViewModel = {
        return SettingViewModel()
    }()
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoutButton: UIButton!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureLogoutButton()
        configureNavigationItem()
        
        // init view model
        initVM()
    }

    // MARK: - Actions
    @IBAction func logoutButtonPressed(_ sender: Any) {
        
    }
    
}


// MARK: - Data source
extension SettingsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as? SettingCell else { return SettingCell() }
        
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        cell.settingCellViewModel = cellVM
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }
}

// MARK: - Delegate
extension SettingsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        viewModel.userPressed(at: indexPath)
        navigateToNextScreen()
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        viewModel.userPressed(at: indexPath)
        return indexPath
    }
}

// MARK: - Configure View
extension SettingsView {
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        // Register cell
        let nib = UINib(nibName: "SettingCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "SettingCell")
    }

    private func configureLogoutButton() {
        logoutButton.addCornerRadius()
    }

    private func configureNavigationItem() {
        self.navigationItem.title = "Settings"
    }
}

// MARK: - Binding
extension SettingsView {
    
    func initVM() {
        // Naive binding
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.initFetch()
    }
}

extension SettingsView {

    func navigateToNextScreen() {
        let vc = AddressListView(nibName: "AddressListView", bundle: nil)
        vc.passedData = viewModel.selectedItem?.title
        navigationController?.pushViewController(vc, animated: true)
    }
}
