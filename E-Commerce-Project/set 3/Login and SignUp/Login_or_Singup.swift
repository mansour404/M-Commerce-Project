//
//  Login_or_Singup.swift
//  finalprojectmock
//
//  Created by Ziyad Qassem on 18/10/2023.
//

import UIKit

class Login_or_Singup: UIViewController {

    @IBOutlet weak var myView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myView.layer.cornerRadius = 15
    }


    @IBAction func SignUpButton(_ sender: UIButton) {
        let vc = SignUpVC()
         vc.modalPresentationStyle = .fullScreen
         present(vc, animated: true)
    }
    
    @IBAction func LoginButton(_ sender: UIButton) {
        let vc = LoginVC()
         vc.modalPresentationStyle = .fullScreen
         present(vc, animated: true)
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func skipBtnTapped(_ sender: UIButton) {
        let vc = TabController()
//        self.navigationController?.pushViewController(vc, animated: true)
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
    }
    

}
