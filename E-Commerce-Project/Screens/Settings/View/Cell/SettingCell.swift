//
//  SettingCell.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 21/10/2023.
//

import UIKit

class SettingCell: UITableViewCell {
    
    // MARK: - Vars
    var settingCellViewModel : SettingCellViewModel? {
        didSet {
            titleLabel.text = settingCellViewModel?.titleText
        }
    }

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

}
