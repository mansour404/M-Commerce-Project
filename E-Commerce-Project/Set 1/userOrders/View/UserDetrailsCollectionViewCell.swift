//
//  UserDetrailsCollectionViewCell.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 04/11/2023.
//

import UIKit

class UserDetrailsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var itemNoLabel: UILabel!
    
    @IBOutlet weak var orderNomberLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
