//
//  ShoppingCartViewController.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 18/10/2023.
//

import UIKit

class ShoppingCartView: UIViewController {
    // MARK: - Vars
    // ProductInfoViewController
    private let viewModel: ShoppingCartViewModel = ShoppingCartViewModel()
    var totalPrice: Double = 0.0
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var orderInfoView: UIView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    
}

extension ShoppingCartView {
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cart"
        setupTableView()
        setupUI()
        bindViewModel()
        viewModel.fetchCartProducts()
    }
   
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isTableViewCount()
        shoppingCartIsEmpty()
    }

    // MARK: - IBActions
    @IBAction func checkoutButtonPressed(_ sender: UIButton) {
//        totalPrice = Double(totalPriceLabel.text ?? "0.0")!
        UserDefaultsHelper.shared.setFinalTotalCost(totalPrice)
        let vc = AddressListView(nibName: "AddressListView", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Functions
    private func setupTableView() {
        let nib = UINib(nibName: "ShoppingCartCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ShoppingCartCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupUI() {
        orderInfoView.layer.cornerRadius = 20
        orderInfoView.clipsToBounds = true
        orderInfoView.dropShadow()
        
        checkoutButton.addCornerRadius()
        checkoutButton.addCornerRadius()
    }
    
    private func bindViewModel() {
        viewModel.reloadTableViewClosure = { [weak self] in
            self?.tableView.reloadData()
            self?.shoppingCartIsEmpty()
        }
        
        viewModel.updateTotalPriceClosure = { [weak self] totalPriceText in
            self?.totalPriceLabel.text = totalPriceText
            var validPrice = totalPriceText
            validPrice.removeLast(5)
            self?.totalPrice = Double(validPrice) ?? 0.0
        }
    }
    
    private func isTableViewCount() {
        if viewModel.cartProductsCount != 0 {
            bottomLayoutConstraint.constant = 16
            UIView.animate(withDuration: 1.2) {
                self.view.layoutIfNeeded()
                // request layout on the *superview*
                //self.view.superview?.layoutIfNeeded()
            }
        } else {
            bottomLayoutConstraint.constant = -220
            UIView.animate(withDuration: 1.0) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func shoppingCartIsEmpty() {
        if viewModel.cartProductsCount < 1{
            tableView.isHidden = true
            orderInfoView.isHidden = true
            checkoutButton.isEnabled = false
            emptyView.isHidden = false
        }
        else {
            tableView.isHidden = false
            orderInfoView.isHidden = false
            checkoutButton.isEnabled = true
            emptyView.isHidden = true
        }
    }
    
}


// MARK: - Data source
extension ShoppingCartView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cartProductsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCartCell", for: indexPath) as? ShoppingCartCell else { return UITableViewCell()}
        viewModel.configCell(cell, at: indexPath.row)
        cell.delegate = self
        return cell
    }
    
}

// MARK: - Delegate
extension ShoppingCartView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 152
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        viewModel.deleteProductFromShoppingCart(at: indexPath.row)
    }
}


extension ShoppingCartView: ShoppingCartCellDelegate {
    func deleteProduct(index: Int) {
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.tableView.reloadData()
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.viewModel.deleteProductFromShoppingCart(forCellID: index)
        }
        
        Alert.showAlert(target: self, title: "Be Careful", message: "You are going to remove product from cart!", actions: [cancelAction, deleteAction])
    }
    
    func updateProductCount(index: Int, count: Int) {
        if count <= 0 {
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                self.tableView.reloadData()
            }
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
                self?.viewModel.deleteProductFromShoppingCart(forCellID: index)
            }
            
            Alert.showAlert(target: self, title: "Be Careful", message: "You are going to remove product from cart!", actions: [cancelAction, deleteAction])
        } else {
            viewModel.updateProductCount(index: index, count: count)
        }
    }
}

