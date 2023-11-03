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
    
   
    @IBOutlet var secondOutletCollection: [UIButton]!
    let categoryViewModel = CategoryViewModel()
    
    @IBOutlet var FirstOutletCollection: [UIButton]!
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.title = "Categories"
        configureCollectionView()
        categoryViewModel.bindresultToHomeViewController = {
            DispatchQueue.main.async {
                self.subMainCollectionView.reloadData()
            }
        }

        navigationItem.setRightBarButtonItems([addFavouriteButton(), addShoppingCartButton()], animated: true)
//        navigationItem.setLeftBarButton(addFSearchButton(), animated: true)
//        configureLoadingDataFromApi()
        
    }
    // MARK: - Configure CollectionView
    private func configureCollectionView() {
        subMainCollectionView.dataSource = self
        subMainCollectionView.delegate = self
        //Registers
        subMainCollectionView.register(UINib(nibName: CellIdentifier.submainCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.submainCollectionViewCell)
    }
    //MARK: - Configure The Loading Data
    func configureLoadingDataFromApi(){

        categoryViewModel.getDataFromApiForHome()

    }
        
    private func addFavouriteButton() -> UIBarButtonItem {
        let heartButton = UIButton(type: .custom)
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.tintColor = UIColor.systemPurple
        heartButton.addTarget(self, action: #selector(navigateToFavourites), for: .touchUpInside)

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
    
//    private func addFSearchButton() -> UIBarButtonItem {
//        let heartButton = UIButton(type: .custom)
//        heartButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
//        heartButton.tintColor = UIColor.systemPurple
////        heartButton.addTarget(self, action: #selector(navigateToFavourites), for: .touchUpInside)
//
//        let heartBarButtonItem = UIBarButtonItem(customView: heartButton)
//        return heartBarButtonItem
//    }
    
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
    // MARK: - ACTIONS
    var filter_1 : String = "all"
    var filter_2 : String = "ALL"
    @IBAction func FirstRowButtons(_ sender: UIButton) {
        
        filter_1 = (sender.titleLabel!.text?.lowercased())!
        categoryViewModel.getDataFromApiForHome(filter1: filter_1, filter2: filter_2)
    }
    
    @IBAction func secondRowButtons(_ sender: UIButton) {
       
        filter_2 = (sender.titleLabel!.text?.uppercased())!
        categoryViewModel.getDataFromApiForHome(filter1: filter_1, filter2: filter_2)
    }
}
// MARK: - UICollectionView DataSource
extension CategoriesViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoryViewModel.getNumberOfProducts() ?? 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = subMainCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.submainCollectionViewCell, for: indexPath) as! SubmainCollectionViewCell
        cell.configure(imageName: categoryViewModel.getImage(index: indexPath.row) ?? "bag", priceText: categoryViewModel.getPrice(index: indexPath.row) ?? "10" , productNameText: categoryViewModel.getTitle(index: indexPath.row) ?? "A")
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
        
        let vc = ProductInfoViewController(nibName: "ProductInfoViewController", bundle: nil)
       
        let id = categoryViewModel.getProductID(index: indexPath.item)
        print(id)
        vc.setID(id: id)
      
        navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: - UICollectionView Delegate

extension CategoriesViewController: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (subMainCollectionView.frame.width / 2) - 10 , height: (subMainCollectionView.frame.height) / 2.5 )
    }
}

