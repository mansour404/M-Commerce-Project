//
//  ReviewCollectionViewCell.swift
//  E-Commerce-Project
//
//  Created by Admin on 22/10/2023.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var revieverImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        //revieverImage.image = UIImage(named: "handbag")
        revieverImage.layer.cornerRadius = 25
        // Initialization code
    }

}
