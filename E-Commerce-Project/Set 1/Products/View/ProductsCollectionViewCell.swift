//
//  ProductsCollectionViewCell.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 25/10/2023.
//

import UIKit
import Cosmos

class ProductsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myView.layer.cornerRadius = 15
    }

}
