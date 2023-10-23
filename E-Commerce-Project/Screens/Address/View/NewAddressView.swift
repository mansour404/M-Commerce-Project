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

/*
 "addresses": [
     {
       "id": 207119551,
       "customer_id": 6940095564,
       "first_name": "Bob",
       "last_name": "Norman",
       "company": null,
       "address1": "Chestnut Street 92",
       "address2": "Apartment 2",
       "city": "Louisville",
       "province": "Kentucky",
       "country": "United States",
       "zip": "40202",
       "phone": "555-625-1199",
       "province_code": "KY",
       "country_code": "US",
       "country_name": "United States",
       "default": true
     }
 */
