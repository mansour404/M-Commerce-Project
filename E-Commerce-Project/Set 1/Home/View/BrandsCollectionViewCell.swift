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
        brandsImageView.downloadImageFrom(imageName)
        if let titleLabel = brandsNamesLabel {
            titleLabel.text = titleText
        }
    }
}
