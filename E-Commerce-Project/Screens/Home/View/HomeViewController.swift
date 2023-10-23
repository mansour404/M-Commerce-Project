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
    @IBOutlet weak var couponsCollectionView: UICollectionView!
    @IBOutlet weak var pageConroller: UIPageControl!
    @IBOutlet weak var brandsCollectionView: UICollectionView!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.title = "Home"
        configureCollectionView()
//        pageConroller.numberOfPages = coupons.count
//        startTimer()
        
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == couponsCollectionView {
            let cell = couponsCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.copounCollectionViewCell, for: indexPath) as! CopounCollectionViewCell
            cell.layer.cornerRadius = 20
            return cell
        } else {
            let cell = brandsCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.brandsCollectionViewCell, for: indexPath)as! BrandsCollectionViewCell
            cell.layer.cornerRadius = 20
            
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
        //        navigationController?.pushViewController(vc, animated: true)
                vc.modalPresentationStyle = .fullScreen
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
