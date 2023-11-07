//
//  ShoppingCartViewController.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 18/10/2023.
//

import UIKit
import Alamofire

class ShoppingCartView: UIViewController {
    // MARK: - Vars
    // ProductInfoViewController
    private let viewModel: ShoppingCartViewModel = ShoppingCartViewModel()
    var totalPrice: Double = 0.0
    var currencySymbol: String = ""
    var customerID = UserDefaultsHelper.shared.getCustomerId()
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var orderInfoView: UIView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var joinUSButton: UIButton!
}

extension ShoppingCartView {
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingCartIsEmpty()
        title = "Cart"
        setupTableView()
        setupUI()
        bindViewModel()
        viewModel.fetchCartProducts()
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // shoppingCartIsEmpty()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isTableViewCount()
    }

    // MARK: - IBActions
    @IBAction func checkoutButtonPressed(_ sender: UIButton) {
//        totalPrice = Double(totalPriceLabel.text ?? "0.0")!
        UserDefaultsHelper.shared.setFinalTotalCost(totalPrice)
        UserDefaultsHelper.shared.setContinueToPayment(true)
        //let vc = AddressListView(nibName: "AddressListView", bundle: nil)
        let vc = OrderViewController(nibName: "OrderViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func joinUSButtonPressed(_ sender: Any) {
        CartList.carts = []
        UserDefaultsHelper.shared.setCustomerId(0)
        UserDefaultsHelper.shared.saveAPI(id: 0)
        AppDelegate.resetViewController()
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
        
//        viewModel.updateTotalPriceClosure = { [weak self] totalPriceText in
//            self?.totalPriceLabel.text = totalPriceText
//            var validPrice = totalPriceText
//            validPrice.removeLast(5)
//            self?.totalPrice = Double(validPrice) ?? 0.0
//        }
        viewModel.updateTotalPriceClosure = { [weak self] (totalPrice , symbol) in
            var currencyRate =  UserDefaultsHelper.shared.getCurrencyRate()
            let actualValue = totalPrice * currencyRate
            let roundedCost = Double(String(format:"%.2f", actualValue)) ?? 1.00
            self?.totalPriceLabel.text = String(roundedCost) + "  " + symbol
//            var validPrice = totalPrice
//            validPrice.removeLast(5)
            self?.totalPrice = roundedCost
            self?.currencySymbol = symbol
        }
    }
    
    private func isTableViewCount() {
        if viewModel.cartProductsCount != 0 {
            bottomLayoutConstraint.constant = 16
            UIView.animate(withDuration: 0.8) {
                self.view.layoutIfNeeded()
                // request layout on the *superview*
                //self.view.superview?.layoutIfNeeded()
            }
        } else {
            bottomLayoutConstraint.constant = -220
            UIView.animate(withDuration: 0.8) {
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
            if customerID == 0 {
                joinUSButton.isHidden = false
            } else {
                joinUSButton.isHidden = true
            }
            //joinUSButton.isHidden = (customerID == 0) ? false : true
        }
        else {
            tableView.isHidden = false
            orderInfoView.isHidden = false
            checkoutButton.isEnabled = true
            emptyView.isHidden = true
            //joinUSButton.isHidden = true
            if customerID == 0 {
                joinUSButton.isHidden = false
                tableView.isHidden = true
                orderInfoView.isHidden = true
                checkoutButton.isEnabled = false
                emptyView.isHidden = false
            } else {
                joinUSButton.isHidden = true
            }
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
        cell.delegate = self // set cell delegate equal self.
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
        viewModel.deleteProductFromShoppingCart(index: indexPath.row)
        //deleteProduct(index: indexPath.row)
    }
}


extension ShoppingCartView: ShoppingCartCellDelegate {

    
    func updateProductCount(index: Int, count: Int) {
        if count <= 0 {
            let cancelAction = UIAlertAction(title: "Close", style: .cancel) { _ in
                self.tableView.reloadData()
            }

            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
                self?.viewModel.deleteProductFromShoppingCart(index: index)
            }

            Alert.showAlert(target: self, title: "Be Careful", message: "You are going to update product from cart!", actions: [cancelAction, deleteAction])
        } else {
            //viewModel.updateProductCount(index: index, count: count)
            viewModel.updateProductCountInShoppingCart(index: index, count: count)
            //test_put_draft_order ()
        }
        
    }
    
    func showAlert(avaibleElements: Int) {
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { _ in
            self.tableView.reloadData()
        }

        Alert.showAlert(target: self, title: "Sorry", message: "The maximum number of products available is \(avaibleElements)" , actions: [okAction])
    }

//    func test_put_draft_order () {
//        let url = "https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/draft_orders/1031372177558.json"
//        let params = ["draft_order":["id":1031372177558,"line_items":[["variant_id":42798192099478,"quantity":0, "sku" : "new sku",
//                                                                       "properties": [["name":"value", "value" : "value2"]]], ["variant_id":42798187446422,"quantity":33, "sku" : "new sku2"]]]]
//
//        let header : HTTPHeaders = ["X-Shopify-Access-Token": "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"]
//
//        Alamofire.AF.request(url, method: .put, parameters: params, headers: header).response { data in
//
//            print("I am done")
//        }
//    }
}

