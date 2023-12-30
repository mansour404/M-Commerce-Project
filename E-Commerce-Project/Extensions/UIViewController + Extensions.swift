//
//  UIViewController + SwiftMessages.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 19/10/2023.
//

import UIKit
import SwiftMessages

// Mapping MessagesTheme with Them.
enum MessagesTheme {
    case info
    case success
    case warning
    case error
}

// MARK: - Display message for network connection
extension UIViewController {
    
    func displayMessage(_ message: String, theme: MessagesTheme) {
        let view = MessageView.viewFromNib(layout: MessageView.Layout.cardView)
        switch theme {
        case .info:
            view.configureTheme(.info)
            view.configureContent(title: "Info", body: message, iconText: "🤗")
        case .success:
            view.configureTheme(.success)
            view.configureContent(title: "Success", body: message, iconText: "🎉")
        case .warning:
            view.configureTheme(.warning)
            view.configureContent(title: "Error", body: message, iconText: "😞")
        case .error:
            view.configureTheme(.error)
            view.configureContent(title: "Error", body: message, iconText: "😓")
        }
        
        view.configureDropShadow()
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        view.button?.isHidden = true
        SwiftMessages.show(view: view)
    }
}


// MARK: - Showing alert
extension UIViewController {
    
    func showAlert(title: String, msg: String, completion: @escaping (UIAlertAction) -> ()) -> UIAlertController {
        let alert : UIAlertController = UIAlertController(title: title, message:msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: completion))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        return alert
    }
}
