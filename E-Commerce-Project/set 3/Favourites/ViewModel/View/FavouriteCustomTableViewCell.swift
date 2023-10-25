//
//  FavouriteCustomTableViewCell.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 25/10/2023.
//

import UIKit

class FavouriteCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var FavouriteProductImage: UIImageView!
    @IBOutlet weak var FavouriteProductName: UILabel!
    @IBOutlet weak var FavouriteProductPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
        separatorInset = UIEdgeInsets(top: 0, left: 500, bottom: 0, right: 0)
        
        FavouriteProductImage.rounded()
        FavouriteProductImage.addBorder()
        
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 20
        cardView.dropShadow()
    }

    
}
