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
    var productviewModel = ProductViewModel()
    var buttonHidden:Bool = true
    var isSearchActive  = false
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Products"
        searchBar.delegate = self
        rateFilterButtonOutlet.isHidden = true
        priceFilterButtonOutlet.isHidden = true
        charFilterButtonOutlet.isHidden = true
        productviewModel.bindresultToProductsViewController = {
            DispatchQueue.main.async {
                self.productsCollectionView.reloadData()
            }
        }
        self.configureLoadingDataFromApi()
        configureCollectionView()
        
    }
    func configureLoadingDataFromApi(){
        if(isSearchActive ){
            productviewModel.getDataFromApiForProduct_WithFilter(SearchText: searchBar.text!)
        }
        else {
            productviewModel.getDataFromApiForProduct()
        }
    }
    // MARK: - Configure CollectionView
    private func configureCollectionView() {
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        //Registers
        productsCollectionView.register(UINib(nibName: CellIdentifier.submainCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.submainCollectionViewCell)
        
    }
    // MARK: - ACTIONS
    @IBAction func filterButtonTapped(_ sender: Any) {
        if buttonHidden{
            rateFilterButtonOutlet.isHidden = false
            priceFilterButtonOutlet.isHidden = false
            charFilterButtonOutlet.isHidden = false
            buttonHidden = false
        } else {
            rateFilterButtonOutlet.isHidden = true
            priceFilterButtonOutlet.isHidden = true
            charFilterButtonOutlet.isHidden = true
            buttonHidden = true
        }

    }
    @IBAction func rateFilterButtonTapped(_ sender: Any) {
    }
    
    @IBAction func priceFilterButtonTapped(_ sender: Any) {
    }
    
    @IBAction func charFilterButtonTapped(_ sender: Any) {
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
            
            return cell
            
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let vc = ProductInfoViewController(nibName: "ProductInfoViewController", bundle: nil)
            print("after calling")
            //vc.modalPresentationStyle = .automatic
            let id = productviewModel.getProductID(index: indexPath.item)
            print(id)
            vc.setID(id: id)
            print("id is set")
            //self.present(vc, animated: true)
            navigationController?.pushViewController(vc, animated: true)

        }
    }
// MARK: - UICollectionView Delegate

extension ProductsViewController: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UISearchBarDelegate
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (productsCollectionView.frame.width / 2) - 10 , height: (productsCollectionView.frame.height) / 2.5 )
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
   
}



   


