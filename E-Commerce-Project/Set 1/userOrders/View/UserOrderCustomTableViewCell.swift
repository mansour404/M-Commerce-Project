//
//  UserOrderdCell.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 25/10/2023.
//

import UIKit

class UserOrderCustomTableViewCell: UITableViewCell {

    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
