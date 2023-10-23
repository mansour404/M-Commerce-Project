//
//  CurrencyCell.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 21/10/2023.
//

import UIKit

class CurrencyCell: UITableViewCell {
    
    @IBOutlet weak var containerCardView: UIView!
    @IBOutlet weak var currencySymbolLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var currencyCellViewModel: CurrencyCellViewModel? {
        didSet {
            currencyLabel.text = currencyCellViewModel?.currencyCode
            currencySymbolLabel.text = "\(currencyCellViewModel?.currencyValue ?? 0.0)"
        }
    }
    
}
