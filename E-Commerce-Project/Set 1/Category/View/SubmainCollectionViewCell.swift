//
//  SubmainCollectionViewCell.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 19/10/2023.
//

import UIKit
import Cosmos

class SubmainCollectionViewCell: UICollectionViewCell {
    // MARK: - Variables
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var exchangeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var myView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myView.layer.cornerRadius = 15
    
    }
    
    // MARK: - configure Nib
    func configure(with imageName: String , priceText: String , productNameText: String , exchangeText : String , rating : Double? ) {
        if let iconImage = imageView {
            iconImage.image = UIImage(named: imageName)
        }
        if let titleLabel = productNameLabel {
            titleLabel.text = productNameText
        }
        if let titleLabel = priceLabel {
            titleLabel.text = priceText
        }
        if let titleLabel = exchangeLabel {
            titleLabel.text = exchangeText
        }
        
//        if let ratingView = rating {
//            ratingView = rating
//        }
    }
}
