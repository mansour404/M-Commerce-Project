//
//  UserOrderDetailsViewController.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 22/10/2023.
//

import UIKit

class UserOrderDetailsViewController: UIViewController {
    // MARK: - Variables
    @IBOutlet weak var userOrderDetailsCollectionView: UICollectionView!
    var orderDetails : UserOrders?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    // MARK: - Configure CollectionView
    private func configureCollectionView() {
        userOrderDetailsCollectionView.dataSource = self
        userOrderDetailsCollectionView.delegate = self
        //Registers
        userOrderDetailsCollectionView.register(UINib(nibName: CellIdentifier.userDetrailsCollectionViewCell , bundle: nil), forCellWithReuseIdentifier: CellIdentifier.userDetrailsCollectionViewCell)
        navigationItem.title = "Orders Details"
        
    }
}
// MARK: - UICollectionView DataSource
extension UserOrderDetailsViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = userOrderDetailsCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.userDetrailsCollectionViewCell, for: indexPath) as! UserDetrailsCollectionViewCell
        
        guard let orderDetails = orderDetails else{ return UICollectionViewCell() }
            if let customerDetails = orderDetails.shipping_address {
                cell.addressLabel.text = customerDetails.address1
                cell.phoneLabel.text = customerDetails.phone
                cell.nameLabel.text = customerDetails.name
                cell.totalPriceLabel.text = orderDetails.total_price
                cell.itemNoLabel.text = "\(orderDetails.line_items?[indexPath.row].quantity ?? 10)"
                //            cell.totalPriceLabel.text = customerDetails.
            } else {
                cell.addressLabel.text = "N/A"
                cell.phoneLabel.text =   "N/A"
                cell.nameLabel.text =    "N/A"
            }
            
            if let itemDetails = orderDetails.line_items{
                cell.titleLabel.text = itemDetails[indexPath.row].title
            } else {
                cell.titleLabel.text = "N/A"
            }
            
            if orderDetails.total_price != nil{
                cell.totalPriceLabel.text = orderDetails.total_price
            } else {
                cell.totalPriceLabel.text = "N/A"
            }
            
            if orderDetails.order_number != nil{
                cell.orderNomberLabel.text = "\(orderDetails.order_number ?? 10)"
            } else {
                cell.orderNomberLabel.text = "N/A"
            }
        
        return cell
    }
}
// MARK: - UICollectionView Delegate

extension UserOrderDetailsViewController: UICollectionViewDelegate , UICollectionViewDelegateFlowLayout
{
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: userOrderDetailsCollectionView.frame.width  , height: userOrderDetailsCollectionView.frame.height)
   }
}

