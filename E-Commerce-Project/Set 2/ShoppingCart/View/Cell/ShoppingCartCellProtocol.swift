//
//  ShoppingCartCellProtocol.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 30/10/2023.
//

import Foundation

protocol ShoppingCartCellProtocol: AnyObject {
    func configureCell(_ product: ShoppingCartModel, index: Int)
    func hideButtons()
    func hideQuantity()
    func setCell(id: Int)
}


protocol ShoppingCartCellDelegate: AnyObject {
    func updateProductCount(index: Int, count: Int)
    func deleteProduct(index: Int)
}
