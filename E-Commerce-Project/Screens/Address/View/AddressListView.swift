//
//  AddressListView.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 21/10/2023.
//

import UIKit

class AddressListView: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!

    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCartTableView()
        configureCheckoutButton()
        //emptyView.isHidden = true
    }

    // MARK: - Actions
    @IBAction func continueButtonPressed(_ sender: Any) {
        
    }
    
    // MARK: - Functions
    func configureCartTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "AddressCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "AddressCell")
    }
    
    func configureCheckoutButton() {
        continueButton.addCornerRadius()
    }
}

// MARK: - Data source
extension AddressListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddressCell", for: indexPath) as? AddressCell else { return UITableViewCell()}
        return cell
    }
}

// MARK: - Delegate
extension AddressListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
}
