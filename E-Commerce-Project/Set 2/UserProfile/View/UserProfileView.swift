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

    
    // MARK: - Outlets
    @IBOutlet weak var noUserUIView: UIView!
    @IBOutlet weak var userUIView: UIView!
    @IBOutlet weak var favouritesTableView: UITableView!
    @IBOutlet weak var ordersTableView: UITableView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        userProfileIsEmpty()
        // Setup bar button items
        navigationItem.setRightBarButtonItems([addSettingsButton(), addShoppingCartButton()], animated: true)
        registerNibs()
        configureTableViews()
        bind()
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
    
    private func bind() {
        favouriteViewModel.bindresultToProductsViewController = {
            DispatchQueue.main.async {
                self.favouritesTableView.reloadData()

            }
        }
        self.favouriteViewModel.getDataFromApiForProduct()
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
                self.fetchOrders()
                self.fetchFavourites()
                
            } else {
                self.noUserUIView.isHidden = false
                self.userUIView.isHidden = true
            }
        }
    }
    
    private func fetchOrders() {
        // Fetch orders using set1 view model
    }
    
    private func fetchFavourites() {
        // Fetch favorites using set3 view model
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
//        let vc = SignUpVC(nibName: "SignUpVC", bundle: nil)
//        navigationController?.pushViewController(vc, animated: true)
        //let rootViewController = UINavigationController(rootViewController: Login_or_Singup())
        CartList.carts = []
        UserDefaultsHelper.shared.setCustomerId(0)
        UserDefaultsHelper.shared.saveAPI(id: 0)
        AppDelegate.resetViewController()
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
            return 2
        } else {
            guard let count = favouriteViewModel.getNumberOfProduct() else { return 0 }
            return count < 2 ? count : 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == ordersTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserOrderCustomTableViewCell", for: indexPath) as? UserOrderCustomTableViewCell else {return  UITableViewCell() }
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
    }
}
