//
//  UIView + dropShadow.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 19/10/2023.
//

import UIKit

extension UIView {
    
    // MARK: - Drop shadow 
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0,height: 4)
        layer.shadowRadius = 4
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
  
}
