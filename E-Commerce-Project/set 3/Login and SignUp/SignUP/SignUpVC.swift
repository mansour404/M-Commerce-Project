//
//  SignUpVC.swift
//  finalprojectmock
//
//  Created by Ziyad Qassem on 18/10/2023.
//

import UIKit

class SignUpVC: UIViewController {
    @IBOutlet weak var userNamefield: UITextField!
    @IBOutlet weak var userPasswordfield: UITextField!
    @IBOutlet weak var userEmailAdressfield: UITextField!
    @IBOutlet weak var userPhoneNumberfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

  
    }

    @IBAction func SignUpPressed(_ sender: UIButton) {
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
