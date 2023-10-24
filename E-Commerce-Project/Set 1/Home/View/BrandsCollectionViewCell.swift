//
//  BrandsCollectionViewCell.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 18/10/2023.
//

import UIKit

class BrandsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var brandsImageView: UIImageView!
    @IBOutlet weak var brandsNamesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // MARK: - configure Nib
    func configure(with imageName: String , titleText: String) {
        //The error from here from king fisher
        if imageName.isEmpty {
            brandsImageView.image = UIImage(named: "handbag")
        }
        else {
            brandsImageView.kf.setImage(with: URL(string: imageName))
        }
        if let titleLabel = brandsNamesLabel {
            titleLabel.text = titleText
        }
    }
}
