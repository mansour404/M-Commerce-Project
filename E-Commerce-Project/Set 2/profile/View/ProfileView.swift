//
//  ProfileView.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 23/10/2023.
//

import UIKit

class ProfileView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setRightBarButtonItems([addSettingsButton(), addShoppingCartButton()], animated: true)
    }


    private func addSettingsButton() -> UIBarButtonItem {
        let heartButton = UIButton(type: .custom)
        heartButton.setImage(UIImage(systemName: "gearshape.fill"), for: .normal)
        heartButton.tintColor = UIColor.systemPurple
        heartButton.addTarget(self, action: #selector(navigateToSettings), for: .touchUpInside)

        let heartBarButtonItem = UIBarButtonItem(customView: heartButton)
        return heartBarButtonItem
    }
    
    private func addShoppingCartButton() -> UIBarButtonItem {
        let heartButton = UIButton(type: .custom)
        heartButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        heartButton.tintColor = UIColor.systemPurple
        heartButton.addTarget(self, action: #selector(navigateToShoppingCart), for: .touchUpInside)

        let shoppingCartBarButtonItem = UIBarButtonItem(customView: heartButton)
        return shoppingCartBarButtonItem
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
