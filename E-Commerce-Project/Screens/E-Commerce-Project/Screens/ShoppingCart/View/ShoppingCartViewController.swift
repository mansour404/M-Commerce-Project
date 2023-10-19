//
//  ShoppingCartViewController.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 18/10/2023.
//

import UIKit

class ShoppingCartViewController: UIViewController {
    // MARK: - Vars
    
    
    // MARK: - Outlets
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var orderInfoView: UIView!
    @IBOutlet weak var subtotalLabel: UILabel!
    @IBOutlet weak var shippingCostLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCartTableView()
        configureCheckoutButton()
        emptyView.isHidden = true
    }
    
    // MARK: - Actions
    @IBAction func checkoutButtonPressed(_ sender: Any) {
    }
    

    // MARK: - Functions
    func configureCartTableView() {
        cartTableView.dataSource = self
        cartTableView.delegate = self
        let nib = UINib(nibName: "ShoppingCartCell", bundle: nil)
        cartTableView.register(nib, forCellReuseIdentifier: "ShoppingCartCell")
    }
    
    func configureCheckoutButton() {
        checkoutButton.addCornerRadius()
    }
}

// MARK: - Data source
extension ShoppingCartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCartCell", for: indexPath) as? ShoppingCartCell else { return UITableViewCell()}
        return cell
    }
}

// MARK: - Delegate
extension ShoppingCartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
}
