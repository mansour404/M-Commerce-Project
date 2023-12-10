//
//  UserOrderViewController.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 22/10/2023.
//

import UIKit

class UserOrderViewController: UIViewController {
    // MARK: - Variables
    @IBOutlet weak var userOrdersCollectionView: UICollectionView!
    var userOrderViewModel = UserOrderViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        userOrderViewModel.bindresultToHomeViewController = {
            DispatchQueue.main.async {
                self.userOrdersCollectionView.reloadData()
            }
        }
        configureCollectionView()
        configureLoadingDataFromApi()
    }
    // MARK: - Configure CollectionView
    private func configureCollectionView() {
        userOrdersCollectionView.dataSource = self
        userOrdersCollectionView.delegate = self
        //Registers
        userOrdersCollectionView.register(UINib(nibName: CellIdentifier.UserOrderCell, bundle: nil), forCellWithReuseIdentifier: CellIdentifier.UserOrderCell)
        navigationItem.title = "Orders"
        
    }
    //MARK: - Configure The Loading Data
    private  func configureLoadingDataFromApi(){
        userOrderViewModel.getDataFromApiForUserOrders()
    }
}

// MARK: - UICollectionView DataSource
extension UserOrderViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userOrderViewModel.getNumberOfOrders() 
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = userOrdersCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.UserOrderCell, for: indexPath) as! UserOrderCell
        
        cell.orderNoLabel.text =  userOrderViewModel.getOrderNumber(index: indexPath.row)
        cell.priceNoLabel.text = userOrderViewModel.getTotalPrice(index: indexPath.row)
        cell.itemsNoLabel.text = userOrderViewModel.getNumberOfItems(index: indexPath.row)
                                        
        cell.layer.cornerRadius = 15
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UserOrderDetailsViewController()
        guard let orderDetails = userOrderViewModel.getAllOrders?.orders?[indexPath.row] else{ return }
        vc.orderDetails = orderDetails
//        print(orderDetails )
        navigationController?.pushViewController(vc, animated: true)
    }
}
// MARK: - UICollectionView Delegate

extension UserOrderViewController: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout
{
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (userOrdersCollectionView.frame.width ) - 30 , height: (userOrdersCollectionView.frame.height) / 5 )
}
}

