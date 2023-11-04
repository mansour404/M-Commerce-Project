//
//  ShoppingCartCellProtocol.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 30/10/2023.
//

import Foundation

protocol ShoppingCartCellProtocol: AnyObject {
    func configureCell(_ product: ShoppingCartModel, index: Int)
}


protocol ShoppingCartCellDelegate: AnyObject {
    func updateProductCount(index: Int, count: Int)
}
