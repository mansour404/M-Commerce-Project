//
//  FavouriteCell.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 20/10/2023.
//

import UIKit

class FavouriteCell: UICollectionViewCell {


    @IBOutlet weak var CellView: UIView!
    @IBOutlet weak var FavouriteProductName: UILabel!
    @IBOutlet weak var FavouriteProductPrice: UILabel!
    @IBOutlet weak var FavouriteProductImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        FavouriteProductImage.rounded()
        FavouriteProductImage.addBorder()
        
        CellView.clipsToBounds = true
        CellView.layer.cornerRadius = 20
        CellView.dropShadow()
    }
    func configureCell (imageURL : String , productname : String ){
        
    }

}
