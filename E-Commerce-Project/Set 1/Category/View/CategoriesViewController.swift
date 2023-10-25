//
//  CategoriesViewController.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 18/10/2023.
//

import UIKit

class CategoriesViewController: UIViewController {
    // MARK: - Variables
    @IBOutlet weak var subMainCollectionView: UICollectionView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.title = "Categories"
        configureCollectionView()

        navigationItem.setRightBarButtonItems([addFavouriteButton(), addShoppingCartButton()], animated: true)
        navigationItem.setLeftBarButton(addFSearchButton(), animated: true)
    }
    // MARK: - Configure CollectionView
    private func configureCollectionView() {
        subMainCollectionView.dataSource = self
        subMainCollectionView.delegate = self
        //Registers
        subMainCollectionView.register(UINib(nibName: CellIdentifier.submainCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.submainCollectionViewCell)
    }
    private func addFavouriteButton() -> UIBarButtonItem {
        let heartButton = UIButton(type: .custom)
        heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        heartButton.tintColor = UIColor.systemPurple
        heartButton.addTarget(self, action: #selector(navigateToFavourites), for: .touchUpInside)

        let heartBarButtonItem = UIBarButtonItem(customView: heartButton)
        return heartBarButtonItem
    }
    
    private func addShoppingCartButton() -> UIBarButtonItem {
        let heartButton = UIButton(type: .custom)
        heartButton.setImage(UIImage(named: "shipped"), for: .normal)
        heartButton.tintColor = UIColor.systemPurple
        heartButton.addTarget(self, action: #selector(navigateToShoppingCart), for: .touchUpInside)

        let shoppingCartBarButtonItem = UIBarButtonItem(customView: heartButton)
        return shoppingCartBarButtonItem
    }
    
    private func addFSearchButton() -> UIBarButtonItem {
        let heartButton = UIButton(type: .custom)
        heartButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        heartButton.tintColor = UIColor.systemPurple
//        heartButton.addTarget(self, action: #selector(navigateToFavourites), for: .touchUpInside)

        let heartBarButtonItem = UIBarButtonItem(customView: heartButton)
        return heartBarButtonItem
    }
    
    @objc func navigateToFavourites(sender: UIButton) {
        let vc = FavouriteListVCViewController(nibName: "FavouriteListVCViewController", bundle: nil)
        // passing data before navigation
        navigationController?.pushViewController(vc, animated: true)
//        vc.modalPresentationStyle = .automatic
//        self.present(vc, animated: true)
        
    }
    
    @objc func navigateToShoppingCart(sender: UIButton) {
        let vc = ShoppingCartView(nibName: "ShoppingCartView", bundle: nil)
        // passing data before navigation
        navigationController?.pushViewController(vc, animated: true)
//        vc.modalPresentationStyle = .automatic
//        self.present(vc, animated: true)
        
    }
}



// MARK: - UICollectionView DataSource
extension CategoriesViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = subMainCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.submainCollectionViewCell, for: indexPath) as! SubmainCollectionViewCell
        return cell
        
    }

}


// MARK: - UICollectionView Delegate

extension CategoriesViewController: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (subMainCollectionView.frame.width / 2) - 10 , height: (subMainCollectionView.frame.height) / 2.5 )
    }
}

