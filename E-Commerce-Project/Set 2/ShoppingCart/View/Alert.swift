//
//  Alert.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 29/10/2023.
//


import UIKit

struct Alert {
    
    private init() {}
    
    static func showAlert(target: UIViewController, title: String, message: String, actions: [UIAlertAction]? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

            guard let actions = actions else {
                alert.addAction(UIAlertAction(title: "Close", style: .destructive))
                return
            }
            for action in actions {
                alert.addAction(action)
            }
            target.present(alert, animated: true)
        }
    }
    
    static func showAlertWithMessage(title: String, message: String, buttonTitle: String, completion: ((UIAlertAction) -> ())? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: completion)
        alert.addAction(action)
        return alert
    }
    
}
