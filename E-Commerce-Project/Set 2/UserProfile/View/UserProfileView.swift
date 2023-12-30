//
//  UserProfileView.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 21/10/2023.
//

import UIKit

class UserProfileView: UIViewController {
    // MARK: - Vars
    var orderList = [String]()
    var favouriteList = [String]()
    var favouriteViewModel = FavouriteViewModel()
    var userOrderViewModel =  UserOrderViewModel()

    
    // MARK: - Outlets
    @IBOutlet weak var noOrdersView: UIView!
    @IBOutlet weak var noFavouritesView: UIView!
    @IBOutlet weak var noUserUIView: UIView!
    @IBOutlet weak var userUIView: UIView!
    @IBOutlet weak var favouritesTableView: UITableView!
    @IBOutlet weak var ordersTableView: UITableView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNoViews()
        userProfileIsEmpty()
        // Setup bar button items
        navigationItem.setRightBarButtonItems([addSettingsButton(), addShoppingCartButton()], animated: true)
        registerNibs()
        configureTableViews()
        bindFavourites()
        bindOrders()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func registerNibs() {
        let favouriteNib = UINib(nibName: "FavouriteCustomTableViewCell", bundle: nil)
        let orderNib = UINib(nibName: "UserOrderCustomTableViewCell", bundle: nil)
        
        favouritesTableView.register(favouriteNib, forCellReuseIdentifier: "FavouriteCustomTableViewCell")
        ordersTableView.register(orderNib, forCellReuseIdentifier: "UserOrderCustomTableViewCell")
    }
    
    private func configureTableViews() {
        ordersTableView.dataSource = self
        ordersTableView.delegate = self
        favouritesTableView.dataSource = self
        favouritesTableView.delegate = self
    }
    
    private func bindFavourites() {
        favouriteViewModel.bindresultToProductsViewController = {
            DispatchQueue.main.async {
                self.favouritesTableView.reloadData()

            }
        }
        self.favouriteViewModel.getDataFromApiForProduct()
    }
    
    private func bindOrders() {
        userOrderViewModel.bindresultToHomeViewController = {
            DispatchQueue.main.async {
                self.ordersTableView.reloadData()
            }
        }
        self.userOrderViewModel.getDataFromApiForUserOrders()
    }
    
    private func hideNoViews() {
        noFavouritesView.isHidden = true
        noOrdersView.isHidden = true
    }
    
}

// MARK: - Guest VS User
extension UserProfileView {
    
    func isUserLoggedIn() {
        UserDefaultsHelper.shared.checkIsCustomerLoggedIn { [weak self] isLoggedIn in
            guard let self = self else { return }
            if isLoggedIn {
                self.userUIView.isHidden = false
                self.noUserUIView.isHidden = true
//                self.fetchOrders()
//                self.fetchFavourites()
                self.bindOrders()
                self.bindFavourites()
                
            } else {
                self.noUserUIView.isHidden = false
                self.userUIView.isHidden = true
            }
        }
    }
    
    private func userProfileIsEmpty() {
        let customerID = UserDefaultsHelper.shared.getCustomerId()
        
        if customerID != 0 {
            userUIView.isHidden = false
            favouritesTableView.isHidden = false
            ordersTableView.isHidden = false
            navigationController?.setNavigationBarHidden(false, animated: true)
            noUserUIView.isHidden = true
            
        } else {
            userUIView.isHidden = true
            favouritesTableView.isHidden = true
            ordersTableView.isHidden = true
            navigationController?.setNavigationBarHidden(true, animated: true)
            noUserUIView.isHidden = false
        }
    }
}


// MARK: - Setup UI
extension UserProfileView {
    private func addSettingsButton() -> UIBarButtonItem {
        let heartButton = UIButton(type: .custom)
        heartButton.setImage(UIImage(systemName: "gearshape"), for: .normal)
        heartButton.tintColor = UIColor.systemPurple
        heartButton.addTarget(self, action: #selector(navigateToSettings), for: .touchUpInside)

        let heartBarButtonItem = UIBarButtonItem(customView: heartButton)
        return heartBarButtonItem
    }
    
    private func addShoppingCartButton() -> UIBarButtonItem {
        let heartButton = UIButton(type: .custom)
        heartButton.setImage(UIImage(systemName: "cart"), for: .normal)
        heartButton.tintColor = UIColor.systemPurple
        heartButton.addTarget(self, action: #selector(navigateToShoppingCart), for: .touchUpInside)

        let shoppingCartBarButtonItem = UIBarButtonItem(customView: heartButton)
        return shoppingCartBarButtonItem
    }
}


// MARK: - Actions
extension UserProfileView {
    
    @IBAction func joinUSButtonPressed(_ sender: Any) {
        CartList.carts = []
        UserDefaultsHelper.shared.setCustomerId(0)
        UserDefaultsHelper.shared.saveAPI(id: 0)
//        AppDelegate.resetViewController()
        let alert = UIAlertController(title: "Thank You", message: "Please Sign Up or Login", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
            let vc = Login_or_Singup()
            vc.modalPresentationStyle = .fullScreen 
            self.present(vc, animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    
    }
    
    @IBAction func seeAllOrdersButtonPressed(_ sender: Any) {
        let vc = UserOrderViewController(nibName: "UserOrderViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func seeAllFavouritesButtonPressed(_ sender: Any) {
        let vc = FavouriteListVCViewController(nibName: "FavouriteListVCViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func navigateToSettings(sender: UIButton) {
        let vc = SettingsView(nibName: "SettingsView", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
//        vc.modalPresentationStyle = .automatic
//        self.present(vc, animated: true)
    }
    
    @objc func navigateToShoppingCart(sender: UIButton) {
        let vc = ShoppingCartView(nibName: "ShoppingCartView", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
//        vc.modalPresentationStyle = .automatic
//        self.present(vc, animated: true)
    }
}

// MARK: - Data source
extension UserProfileView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ordersTableView {
            //return  orderList.count < 2 ? orderList.count : 2
            let count = userOrderViewModel.getNumberOfOrders()
            if count == 0 {
                ordersTableView.isHidden = true
                noOrdersView.isHidden = false
            } else {
                ordersTableView.isHidden = false
                noOrdersView.isHidden = true
            }
            return count < 2 ? count : 2
        } else {
            guard let count = favouriteViewModel.getNumberOfProduct() else { return 0 }
            if count == 0 {
                favouritesTableView.isHidden = true
                noFavouritesView.isHidden = false
            } else {
                favouritesTableView.isHidden = false
                noFavouritesView.isHidden = true
            }
            return count < 2 ? count : 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == ordersTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserOrderCustomTableViewCell", for: indexPath) as? UserOrderCustomTableViewCell else {return  UITableViewCell() }
            cell.orderNumberLabel.text =  userOrderViewModel.getOrderNumber(index: indexPath.row)
            cell.priceLabel.text = userOrderViewModel.getTotalPrice(index: indexPath.row)
            cell.itemLabel.text = userOrderViewModel.getNumberOfItems(index: indexPath.row)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCustomTableViewCell", for: indexPath) as? FavouriteCustomTableViewCell else { return UITableViewCell() }
            
            cell.configureCell(imageURL: favouriteViewModel.getImageUrl(index: indexPath.row) ?? "", productname: favouriteViewModel.getTitle(index: indexPath.row) ?? "Bag", productPrice: favouriteViewModel.getprice(index: indexPath.row) ?? "10 USD")
            
            return cell
        }
    }
}

// MARK: - Delegate
extension UserProfileView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView == ordersTableView ? 120 : 115
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: - Run did select function
        if tableView == ordersTableView {
//            let vc = UserOrderDetailsViewController()
//            guard let orderDetails = userOrderViewModel.getAllOrders?.orders?[indexPath.row] else{ return }
//            vc.orderDetails = orderDetails
//            //        print(orderDetails )
//            navigationController?.pushViewController(vc, animated: true)
            
            let vc = UserOrderDetailsViewController()
            //HERE
            let orderDetails = userOrderViewModel.orderArr[indexPath.row]
            vc.orderDetails = orderDetails
    //        print(orderDetails )
            navigationController?.pushViewController(vc, animated: true)
        } else {
//            let vc = ProductInfoViewController()
//            let productId = favouriteViewModel.productId
//            vc.view_model.id = Int64(productId!)
//            guard let orderDetails = userOrderViewModel.getAllOrders?.orders?[indexPath.row] else{ return }
//            vc.orderDetails = orderDetails
            //        print(orderDetails )
//            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
