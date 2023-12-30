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
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var noItemImage: UIImageView!
    
    @IBOutlet var secondOutletCollection: [UIButton]!
    let categoryViewModel = CategoryViewModel()
    
    @IBOutlet var FirstOutletCollection: [UIButton]!
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.title = "Categories"
        indicator.startAnimating()
        subMainCollectionView.isHidden = true
        configureLoadingDataFromApi()

        configureCollectionView()
        categoryViewModel.bindresultToHomeViewController = {
            DispatchQueue.main.async {
                self.subMainCollectionView.reloadData()
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
                self.subMainCollectionView.isHidden = false

            }
        }
        noItemImage.isHidden = true
        navigationItem.setRightBarButtonItems([addFavouriteButton(), addShoppingCartButton()], animated: true)
        
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

        //categoryViewModel.getDataFromApiForHome()
        categoryViewModel.getFavouriteItems()

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
        if categoryViewModel.getNumberOfProducts() == 0 {
            noItemImage.isHidden = false
        } else {
            noItemImage.isHidden = true
        }
        
        return categoryViewModel.getNumberOfProducts() ?? 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = subMainCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.submainCollectionViewCell, for: indexPath) as! SubmainCollectionViewCell
        
        let price = categoryViewModel.getPrice(index: indexPath.row) ?? "10"
        let (priceText, symbol) = CurrencyManager.returnPriceAndSymbol(price: price)
        
//        cell.configure(imageName: categoryViewModel.getImage(index: indexPath.row) ?? "bag", priceText: categoryViewModel.getPrice(index: indexPath.row) ?? "10" , productNameText: categoryViewModel.getTitle(index: indexPath.row) ?? "A")
        
        cell.configure(imageName: categoryViewModel.getImage(index: indexPath.row) ?? "bag", priceText: priceText , productNameText: categoryViewModel.getTitle(index: indexPath.row) ?? "A", exchangeText: symbol)
        
        cell.product_title = categoryViewModel.getTitle(index: indexPath.item)
        cell.product_id = categoryViewModel.getID(index: indexPath.item)
        cell.product_Image = categoryViewModel.getImage(index: indexPath.row) ?? "bag"
        cell.product_Variant_Id = categoryViewModel.getVariantId(index: indexPath.row)
        cell.product_Price = categoryViewModel.getPrice(index: indexPath.row) ?? "10"
        //cell.product_Variant_Id =
        
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
        var isFavorite = false
        for item in categoryViewModel.favourite_items_array {
            
            
            if item.line_items![0].variant_id == categoryViewModel.getVariantId(index: indexPath.item) &&
                item.line_items![0].title == categoryViewModel.getTitle(index: indexPath.item)
            {
                
                print("found a match")
                print(item.line_items![0].title, categoryViewModel.getTitle(index: indexPath.item))
                isFavorite = true
                //cell.draftOrder = item.id
            }
        }
        //cell.favoriteButton?.isSelected = isFavorite
        cell.colorheart(colored: isFavorite)
        
        //cell.setControllerFavourite()
        
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

