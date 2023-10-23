//
//  CopounCollectionViewCell.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 18/10/2023.
//

import UIKit

class CopounCollectionViewCell: UICollectionViewCell {

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




