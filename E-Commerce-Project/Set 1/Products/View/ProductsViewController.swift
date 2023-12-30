//
//  ProductsViewController.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 21/10/2023.
//

import UIKit

class ProductsViewController: UIViewController {
    // MARK: - Variables
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterButtonOutlet: UIButton!
    @IBOutlet weak var rateFilterButtonOutlet: UIButton!
    @IBOutlet weak var priceFilterButtonOutlet: UIButton!
    @IBOutlet weak var charFilterButtonOutlet: UIButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    var productviewModel = ProductViewModel()
    var isSearchActive  = false
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Products"
        indicator.startAnimating()
        productsCollectionView.isHidden = true
        searchBar.delegate = self
        
        self.configureLoadingDataFromApi()

//        productviewModel.bindresultToProductsViewController = {
//            DispatchQueue.main.async {
//                self.productsCollectionView.reloadData()
//                self.indicator.stopAnimating()
//                self.indicator.hidesWhenStopped = true
//                self.productsCollectionView.isHidden = false
//            }
//        }
        configureCollectionView()

    }
    override func viewWillAppear(_ animated: Bool) {
        productviewModel.bindresultToProductsViewController = {
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.indicator.hidesWhenStopped = true
                self.productsCollectionView.isHidden = false
                self.productsCollectionView.reloadData()
            }
        }
        
        productviewModel.getFavouriteItems {
            self.productviewModel.getDataFromApiForProduct()
        }
    }
    func configureLoadingDataFromApi(){
        
        if(isSearchActive ){
            //productviewModel.getDataFromApiForProduct_WithFilter(SearchText: searchBar.text!)
            productviewModel.getFavouriteItems {
                self.productviewModel.getDataFromApiForProduct_WithFilter(SearchText: self.searchBar.text!)
            }
        }
        else {
            //productviewModel.getDataFromApiForProduct()
            productviewModel.getFavouriteItems {
                self.productviewModel.getDataFromApiForProduct()
            }
        }
    }
    // MARK: - Configure CollectionView
    private func configureCollectionView() {
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        //Registers
        productsCollectionView.register(UINib(nibName: CellIdentifier.submainCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.submainCollectionViewCell)
        
    }

  
}
    // MARK: - UICollectionView DataSource
    extension ProductsViewController:UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return productviewModel.getNumberOfProduct() ?? 1
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = productsCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.submainCollectionViewCell, for: indexPath) as! SubmainCollectionViewCell
            
            cell.productNameLabel.text = productviewModel.getTitle(index: indexPath.row)
           cell.imageView.downloadImageFrom(productviewModel.getid(index: indexPath.row))
            
            cell.product_title = productviewModel.getTitle(index: indexPath.item)
            cell.product_id = Int(productviewModel.getProductID(index: indexPath.item))
            cell.product_Price = productviewModel.getPrice(index: indexPath.row)
            cell.product_Image = productviewModel.getid(index: indexPath.row)
            cell.product_Variant_Id = productviewModel.getVariant_Id(index: indexPath.row)
//            let price = productviewModel.getPrice(index: indexPath.row) ?? "10"
            let price = productviewModel.getPrice(index: indexPath.row) ?? "99"
            let (priceText, symbol) = CurrencyManager.returnPriceAndSymbol(price: price)
            print("+++++++++++")
            print(priceText, symbol)
            print("+++++++++++")

            //cell.configure(imageName: <#T##String#>, priceText: <#T##String#>, productNameText: <#T##String#>, exchangeText: <#T##String#>)
            
            cell.configure(imageName: productviewModel.getid(index: indexPath.row) ?? "bag", priceText: priceText , productNameText: productviewModel.getTitle(index: indexPath.row) ?? "A", exchangeText: symbol)
            
            var isFavorite = false
            for item in productviewModel.favourite_items_array {
                
                
                if item.line_items![0].variant_id == productviewModel.getVariant_Id(index: indexPath.item) &&
                    item.line_items![0].title == productviewModel.getTitle(index: indexPath.item)
                {
                    
                    print("found a match")
                    print(item.line_items![0].title, productviewModel.getTitle(index: indexPath.item))
                    isFavorite = true
                    //cell.draftOrder = item.id
                }
            }
            //cell.favoriteButton?.isSelected = isFavorite
            cell.colorheart(colored: isFavorite)
            cell.layer.cornerRadius = 20
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.lightGray.cgColor
            return cell
            
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let vc = ProductInfoViewController(nibName: "ProductInfoViewController", bundle: nil)
            print("after calling")
//            vc.modalPresentationStyle = .automatic
            let id = productviewModel.getProductID(index: indexPath.item)
            print(id)
            vc.setID(id: id)
            print("id is set")
            self.navigationController?.pushViewController(vc, animated: true)
//            self.present(vc, animated: true)
        }
    }
// MARK: - UICollectionView Delegate

extension ProductsViewController: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UISearchBarDelegate
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (productsCollectionView.frame.width / 2) - 10 , height: (productsCollectionView.frame.height) / 3.5 )
    }
//    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        <#code#>
//    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.isEmpty == true){
            isSearchActive = false
        }
        else {
            isSearchActive = true
        }
        configureLoadingDataFromApi()
    
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       //(collectionView, willDisplay: cell, forItemAt: indexPath)
//        let cell = cell as! SubmainCollectionViewCell
//        cell.setControllerFavourite()
            // Your code here
       }
}



   


