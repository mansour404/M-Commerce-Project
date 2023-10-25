//
//  FavouriteCell.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 20/10/2023.
//

import UIKit

class FavouriteCell: UICollectionViewCell {

    @IBOutlet weak var FavouriteProductPrice: UILabel!
    @IBOutlet weak var FavouriteProductName: UILabel!
    @IBOutlet weak var FavouriteProductImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell (imageURL : String , productname : String ){
        
    }

}
