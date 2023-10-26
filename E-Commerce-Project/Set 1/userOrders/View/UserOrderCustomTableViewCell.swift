//
//  UserOrderdCell.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 25/10/2023.
//

import UIKit

class UserOrderCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        separatorInset = UIEdgeInsets(top: 0, left: 500, bottom: 0, right: 0)
        
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 20
        cardView.dropShadow()
    }

    
}
