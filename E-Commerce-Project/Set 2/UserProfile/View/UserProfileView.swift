//
//  UserProfileView.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 23/10/2023.
//

import UIKit

class UserProfileView: UIViewController {
    // MARK: - Vars
    var orderList = [String]()
    var favouriteList = [String]()
    
    // MARK: - Outlets
    @IBOutlet weak var noUserUIView: UIView!
    @IBOutlet weak var userUIView: UIView!
    @IBOutlet weak var favouritesTableView: UITableView!
    @IBOutlet weak var ordersTableView: UITableView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup bar button items
        navigationItem.setRightBarButtonItems([addSettingsButton(), addShoppingCartButton()], animated: true)
        registerNibs()
        configureTableViews()
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
}

// MARK: - Guest VS User
extension UserProfileView {
    func isUserLoggedIn() {
        UserDefaultsHelper.shared.checkIsUserLoggedIn { [weak self] isLoggedIn in
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
    @IBAction func signInButtonPressed(_ sender: Any) {
//        let vc = LoginVC(nibName: "LoginVC", bundle: nil)
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
//        let vc = SignUpVC(nibName: "SignUpVC", bundle: nil)
//        navigationController?.pushViewController(vc, animated: true)
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
        // passing data before navigation
        //navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .automatic
        self.present(vc, animated: true)
        
    }
    
    @objc func navigateToShoppingCart(sender: UIButton) {
        let vc = ShoppingCartView(nibName: "ShoppingCartView", bundle: nil)
        // passing data before navigation
        //navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .automatic
        self.present(vc, animated: true)
    }
}

// MARK: - Table view data source
extension UserProfileView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == ordersTableView {
            //return  orderList.count < 2 ? orderList.count : 2
            return 2
        } else {
            //return  favouriteList.count < 2 ? orderList.count : 2
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == ordersTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserOrderCustomTableViewCell", for: indexPath) as? UserOrderCustomTableViewCell else {return  UITableViewCell() }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCustomTableViewCell", for: indexPath) as? FavouriteCustomTableViewCell else { return UITableViewCell() }
            return cell
        }
    }
}

// MARK: - Table view delegate
extension UserProfileView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView == ordersTableView ? 120 : 105
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: - Run did select function
    }
}
