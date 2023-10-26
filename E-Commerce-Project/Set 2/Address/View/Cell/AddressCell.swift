//
//  AddressCell.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 21/10/2023.
//

import UIKit

class AddressCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var addresslabel: UILabel!
    
    @IBOutlet weak var locationImageView: UIImageView!
    @IBOutlet weak var cartView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        locationImageView.rounded()
        locationImageView.addBorder()
        // remove seprator
        separatorInset = UIEdgeInsets(top: 0, left: 500, bottom: 0, right: 0)
        cartView.layer.cornerRadius = 20
        cartView.clipsToBounds = true
        cartView.dropShadow()
        
    }

    @IBAction func removeAddressButtonPressed(_ sender: Any) {
        
    }
    
    var addressCellViewModel: AddressCellViewModel? {
        didSet {
            nameLabel.text = addressCellViewModel?.name
            cityLabel.text = addressCellViewModel?.city
            addresslabel.text = addressCellViewModel?.address
        }
    }
}
