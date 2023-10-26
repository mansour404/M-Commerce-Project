//
//  Login_or_Singup.swift
//  finalprojectmock
//
//  Created by Ziyad Qassem on 18/10/2023.
//

import UIKit

class Login_or_Singup: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func SignUpButton(_ sender: UIButton) {
        
    }
    
    @IBAction func LoginButton(_ sender: UIButton) {
        let vc = LoginVC()
//    vc.modalPresentationStyle = .automatic
//        ().present(vc, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func SkipButtons(_ sender: UIButton) {
        let vc = TabController()
        navigationController?.pushViewController(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
