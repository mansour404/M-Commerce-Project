//
//  NewAddressView.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 21/10/2023.
//

import UIKit

class NewAddressView: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var GovernorateTextField: UITextField!
    @IBOutlet weak var addtionalNoteTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var isPrimeAddressSwitch: UISwitch!
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    // MARK: - Actions
    @IBAction func saveAddressButtonPressed(_ sender: Any) {
        
    }
    
}
