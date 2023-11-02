//
//  ShoppingCartCell.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 18/10/2023.
//

import UIKit

class ShoppingCartCell: UITableViewCell {
    
    // MARK: - Vars
    weak var delegate: ShoppingCartCellDelegate?
    private var index: Int?
    private var count: Int = 1
    var numberOfCartItems: Int = 0
    var availableElements: Int = 0
    
    // MARK: - Outlets
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productCountLabel: UILabel!
    
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none // disable selection style
        productImageView.rounded()
        productImageView.addBorder()
        // remove separator, shift separatorInset to rigt by 500
        separatorInset = UIEdgeInsets(top: 0, left: 500, bottom: 0, right: 0)
        // round cart view
        cartView.layer.cornerRadius = 20
        cartView.clipsToBounds = true
        cartView.dropShadow()
    }
    
    // MARK: - Actions
    
    @IBAction func plusItemButtonPressed(_ sender: Any) {
        if (numberOfCartItems < availableElements) {
            count += 1;
        }
        updateNumberLabel()
        print("plus")
        
        count += 1
        if let cellID = index {
            delegate?.updateProductCount(index: cellID, count: count)
            //delegate
        }
    }
    
    @IBAction func minusItemButtonPressed(_ sender: Any) {
        count -= 1
        if let cellID = index {
            delegate?.updateProductCount(index: cellID, count: count)
        }
    }
   
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        if let cellID = index {
            delegate?.deleteProduct(index: cellID)
        }
    }
    
    func updateNumberLabel () {
        productPriceLabel.text = String(numberOfCartItems)
    }
    
}

// MARK: - Conform cell protocol
extension ShoppingCartCell: ShoppingCartCellProtocol {
    func configureCell(_ product: ShoppingCartModel, index: Int) {
        productImageView.downloadImageFrom(product.image, placeHolder: "lazaApp")
        productTitleLabel.text = product.title
        productPriceLabel.text = "\(product.price ?? 100)  EGP"
        productCountLabel.text = "\(product.quantity ?? 1)"
        count = product.quantity ?? 1
        availableElements = product.availableElements ?? 1
        self.index = index
    }
    
    func hideButtons() {
        plusButton.isHidden = true
        minusButton.isHidden = true
    }
    
    func hideQuantity() {
        minusButton.superview?.isHidden = true
    }
    
    func setCell(id: Int) {
        index = id
    }
    
}
