//
//  FavouriteCell.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 20/10/2023.
//

import UIKit

class FavouriteCell: UICollectionViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var FavouriteProductPrice: UILabel!
    @IBOutlet weak var FavouriteProductName: UILabel!
    @IBOutlet weak var FavouriteProductImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        FavouriteProductImage.rounded()
        FavouriteProductImage.addBorder()
        
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 20
        cardView.dropShadow()
    }
    func configureCell (imageURL : String , productname : String ,productPrice : String ){
        FavouriteProductImage.downloadImageFrom(imageURL)
        if (productname.isEmpty == false) {
            FavouriteProductName.text = productname
        }
        if (productPrice.isEmpty == false) {
            FavouriteProductPrice.text = productPrice
        }
    }

}
