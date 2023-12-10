//
//  FavouriteListVCViewController.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 20/10/2023.
//

import UIKit

class FavouriteListVCViewController: UIViewController {
    var namearray : [String] = []
    var pricearray : [String] = []
    var FavouriteCollectionView : UICollectionView!
    var favouriteViewModel = FavouriteViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
  
        self.ConfigureUI()
        favouriteViewModel.bindresultToProductsViewController = {
            DispatchQueue.main.async {
                self.FavouriteCollectionView.reloadData()

            }
        }
      
            self.favouriteViewModel.getDataFromApiForProduct()
        
              //  favouriteViewModel.getproducts()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        favouriteViewModel.bindresultToProductsViewController = {
            DispatchQueue.main.async {
                self.FavouriteCollectionView.reloadData()

            }
        }
    }
    func ConfigureUI() {
        let layout = UICollectionViewCompositionalLayout(section: Favouriteitemssection())
        FavouriteCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(FavouriteCollectionView)
        
        FavouriteCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        FavouriteCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        FavouriteCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        FavouriteCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        FavouriteCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        FavouriteCollectionView.dataSource = self
        FavouriteCollectionView.delegate = self
        FavouriteCollectionView.register(UINib(nibName: "FavouriteCell", bundle: nil), forCellWithReuseIdentifier: "FavouriteCell")
    }
    func Favouriteitemssection()->NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(360)
            , heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
        , heightDimension: .absolute(132))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
        , subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
            , bottom: 15, trailing: 15)
            
        let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15
            , bottom: 10, trailing: 0)
     
           
            
            return section
        }


}
extension FavouriteListVCViewController :UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouriteViewModel.getNumberOfProduct() ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = FavouriteCollectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteCell", for: indexPath) as! FavouriteCell
        cell.configureCell(imageURL: favouriteViewModel.getImageUrl(index: indexPath.row) ?? "", productname: favouriteViewModel.getTitle(index: indexPath.row) ?? "Bag", productPrice: favouriteViewModel.getprice(index: indexPath.row) ?? "10 USD")
        return cell
    }
    
    
    
}
