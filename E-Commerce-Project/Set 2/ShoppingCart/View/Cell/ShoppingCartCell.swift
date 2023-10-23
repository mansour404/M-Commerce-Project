//
//  ShoppingCartCell.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 18/10/2023.
//

import UIKit

class ShoppingCartCell: UITableViewCell {
    
    // MARK: - Vars
    
    
    // MARK: - Outlets
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productCountLabel: UILabel!
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none // disable selection style
        productImageView.rounded()
        productImageView.addBorder()
        // remove separator, shift separatorInset to rigt by 500
        separatorInset = UIEdgeInsets(top: 0, left: 500, bottom: 0, right: 0)
        // round cart view
        cartView.layer.cornerRadius = 20
        cartView.clipsToBounds = true
        cartView.dropShadow()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK: - Actions
    @IBAction func removeItemButtonPressed(_ sender: Any) {
    }
    
    @IBAction func plusItemButtonPressed(_ sender: Any) {
    }
    
    @IBAction func minusItemButtonPressed(_ sender: Any) {
    }
    
    // MARK: - Functions
}
