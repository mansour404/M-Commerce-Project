//
//  ProductImageCell.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 03/11/2023.
//

import UIKit

class ProductImageCell: UICollectionViewCell {

    @IBOutlet weak var couponImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - configure Nib
    func configure(with imageName: String) {
        if let iconImage = couponImageView {
            iconImage.image = UIImage(named: imageName)
            
        }
    }
}
