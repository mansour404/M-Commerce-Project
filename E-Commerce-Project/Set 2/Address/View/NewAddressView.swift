//
//  NewAddressView.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 21/10/2023.
//

import UIKit

protocol DelegateProtocol { // protocol declaration
    func backValue(address: Address?)
}

class NewAddressView: UIViewController {
    
    // MARK: -Vars
    var viewModel: AddressViewModel!
    var newAddress: Address!
    var delegate: DelegateProtocol? // protocol reference
    
    // MARK: - Outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var isDefaultAddressSwitch: UISwitch!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFieldDelegate()
        viewModel = AddressViewModel(addressService: AddressService())
        
    }

    // MARK: - Actions
    @IBAction func saveAddressButtonPressed(_ sender: Any) {
        view.endEditing(true)
        creatNewAddress()
        delegate?.backValue(address: newAddress)  // protocol call
        self.dismiss(animated: true)
//        saveChanges()
    }
    
    private func configureTextFieldDelegate() {
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        countryTextField.delegate = self
        cityTextField.delegate = self
        addressTextField.delegate = self
        phoneNumberTextField.delegate = self
    }
}


// MARK: - Textfield delegate

extension NewAddressView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTextField {
            lastNameTextField.becomeFirstResponder()
        } else if textField == lastNameTextField {
            countryTextField.becomeFirstResponder()
        } else if textField == countryTextField {
            cityTextField.becomeFirstResponder()
        } else if textField == cityTextField {
            addressTextField.becomeFirstResponder()
        } else if textField == addressTextField {
            phoneNumberTextField.becomeFirstResponder()
        } else if textField == phoneNumberTextField {
            creatNewAddress()
            delegate?.backValue(address: newAddress)
            view.endEditing(true)
           // saveChanges()
        }
        return true
    }
    
    // override this func to hide keyboard when touch any empty part of screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension NewAddressView {
    func creatNewAddress() {
        guard let firstName = firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !firstName.isEmpty else  {
            configureAlertController(title: "First name is required", message: "Please insert your first name")
            return
        }
        
        guard let lastName = lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !lastName.isEmpty else {
            configureAlertController(title: "Last name is required", message: "Please insert your last name")
            return
        }
        
        guard let country = countryTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !country.isEmpty else {
            configureAlertController(title: "Country is required", message: "Please insert your Country")
            return
        }
        
        guard let city = cityTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !city.isEmpty else {
            configureAlertController(title: "City is required", message: "Please insert your city")
            return
        }
        
        guard let address = addressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !address.isEmpty else {
            configureAlertController(title: "Address is required", message: "Please insert your address")
            return
        }
       
        guard let phoneNumber = phoneNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), isValidPhoneNumber(phoneNumber) else {
            configureAlertController(title: "Not valid", message: "Please insert valid phone number")
            return
        }
        
        let isDefault = isDefaultAddressSwitch.isOn
        
        
        let customerId = UserDefaultsHelper.shared.getCustomerId()
        /*
        guard (customerId != 0) else {
            configureAlertController(title: "Error", message: "Some thing error happened please try again")
            return
        }
        */
        
        let name = firstName + " " + lastName
        let newAddress = Address(id: nil, customerId: customerId, firstName: firstName, lastName: lastName, name: name, address1: address, address2: nil, city: city, country: country, phone: phoneNumber, isDefault: isDefault)
        self.newAddress = newAddress
        viewModel.creatNewAddress(address: newAddress)
    }
    
    
    private func configureAlertController(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .destructive)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    private func isValidPhoneNumber( _ phoneNumber: String) -> Bool{
        let format = "SELF MATCHES[c] %@"
        let egyptPhoneRegex = "^(01)[0-2,5]{1}[0-9]{8}"
        let predicate = NSPredicate(format: format, egyptPhoneRegex)
        return predicate.evaluate(with: phoneNumber)
    }
    
    private func saveChanges() {
        view.endEditing(true)
        creatNewAddress()
        delegate?.backValue(address: newAddress)  // protocol call
        self.dismiss(animated: true)
    }
}
