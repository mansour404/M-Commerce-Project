//
//  UserOrderDetailsViewController.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 22/10/2023.
//

import UIKit

class UserOrderDetailsViewController: UIViewController {
    // MARK: - Variables
    @IBOutlet weak var orderStatusLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var itemNoLabel: UILabel!
    
    @IBOutlet weak var itemDiscreptionLabel: UILabel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Orders Details"


    }
}
