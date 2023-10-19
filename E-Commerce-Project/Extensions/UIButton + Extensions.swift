//
//  UIButton + Extensions.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 19/10/2023.
//

import UIKit

extension UIButton {
    
    // MARK: - Corner radius
    func addCornerRadius(_ cornerRadius: CGFloat = 10, borderWidth: CGFloat = 2.0, borderColor: CGColor? = UIColor.white.cgColor) {
        clipsToBounds = true
        //layer.sh
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor
        layer.borderWidth = borderWidth
    }
}
