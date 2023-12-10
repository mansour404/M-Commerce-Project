//
//  OptionCollectionViewCell.swift
//  E-Commerce-Project
//
//  Created by Admin on 20/10/2023.
//

import UIKit

class OptionCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var button_container: UIView!
    
    @IBOutlet weak var optionValue: UILabel!
    
    
    func setOptionValue (value : String) {
        //optionButton.setTitle(value, for: .normal)
        optionValue.text = value
    }
    
    func select () {
        button_container.backgroundColor = .darkGray
    }
    
    func unselect () {
        button_container.backgroundColor = .white
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        button_container.layer.cornerRadius = 20
        button_container.clipsToBounds = true
        button_container.dropShadow()
    }

}
