//
//  HomeViewController.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 18/10/2023.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - Variables
    var timer : Timer?
    var currentCellIndex = 0
    
    var homeViewModel = HomeViewModel()


    var brandData : Brands?
    @IBOutlet weak var couponsCollectionView: UICollectionView!
    @IBOutlet weak var pageConroller: UIPageControl!
    @IBOutlet weak var brandsCollectionView: UICollectionView!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.title = "Home"
        self.configureLoadingDataFromApi()
      
           
           
        homeViewModel.bindresultToHomeViewController = {
            DispatchQueue.main.async {
                self.brandsCollectionView.reloadData()
            }
            
        }
        configureCollectionView()
//        pageConroller.numberOfPages = coupons.count
//        startTimer()
        
       
        navigationItem.setRightBarButtonItems([addFavouriteButton(), addShoppingCartButton()], animated: true)
        navigationItem.setLeftBarButton(addFSearchButton(), animated: true)
    }
    //MARK: - Configure The Loading Data
    func configureLoadingDataFromApi(){

        homeViewModel.getDataFromApiForHome()
        //        homeViewModel.getData(Handler: { (dataValue:Brands?, error: Error?) in
        //            if let data = dataValue {
        //                self.brandData = data
        //                DispatchQueue.main.async {
        //                    self.brandsCollectionView.reloadData()
        //                }
        //                //                        print(self.brandData!.smart_collections)
        //            }else {
        //                if let error = error{
        //                    print(error.localizedDescription)
        //                }
        //            }
        //        }
        //        )}
    }
        
    // MARK: - Configure CollectionView
    private func configureCollectionView() {
        couponsCollectionView.dataSource = self
        couponsCollectionView.delegate = self
        brandsCollectionView.dataSource = self
        brandsCollectionView.delegate = self
        
        //Registers
        couponsCollectionView.register(UINib(nibName: CellIdentifier.copounCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.copounCollectionViewCell)
        
        brandsCollectionView.register(UINib(nibName: CellIdentifier.brandsCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.brandsCollectionViewCell)
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
    
    // MARK: - Go to next coupon
//    func startTimer(){
//        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
//    }

//  @objc func moveToNextIndex(){
//      if currentCellIndex < coupons.count - 1 {
//          currentCellIndex += 1
//      }else{
//          currentCellIndex = 0
//      }
//      couponsCollectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
//      pageConroller.currentPage = currentCellIndex
//        }
}
    // MARK: - UICollectionView DataSource
extension HomeViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.getNumberOfBrands() ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == couponsCollectionView {
            let cell = couponsCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.copounCollectionViewCell, for: indexPath) as! CopounCollectionViewCell
            cell.layer.cornerRadius = 20
            return cell
        } else {
            let cell = brandsCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.brandsCollectionViewCell, for: indexPath)as! BrandsCollectionViewCell
            cell.configure(with:homeViewModel.getImage(index: indexPath.row) ?? "bag", titleText: homeViewModel.getTitle(index: indexPath.row) ?? "A")
            
            cell.layer.cornerRadius = 20
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.lightGray.cgColor
            
            
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == couponsCollectionView {
            let alert = UIAlertController(title: "Congratulations", message: "Enjoy your discount", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
                let vc = ProductsViewController()
            homeViewModel.setSelectedBrandID(Index: indexPath.row)
        //        navigationController?.pushViewController(vc, animated: true)
            vc.modalPresentationStyle = .automatic
                self.present(vc, animated: true)
            }
        }
    }

        
// MARK: - UICollectionView Delegate
extension HomeViewController: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == couponsCollectionView {
            return CGSize(width: couponsCollectionView.frame.width , height: couponsCollectionView.frame.height)
        }else{
            return CGSize(width: (brandsCollectionView.frame.width - 20)/2  , height: brandsCollectionView.frame.height/2)
            
        }
    }
}

