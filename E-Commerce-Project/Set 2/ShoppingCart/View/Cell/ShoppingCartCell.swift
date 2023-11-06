//
//  ShoppingCartCell.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 18/10/2023.
//

import UIKit
import Alamofire

class ShoppingCartCell: UITableViewCell {
    
    // MARK: - Vars
    weak var delegate: ShoppingCartCellDelegate?
    private var cellIndex: Int?
    private var productCount: Int = 0
    var availableElements: Int = 0 // availableElements always return nil.
    
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
//        if productCount < availableElements  {
//            guard let button = minusButton else { return }
//            button.isEnabled = true
//
//        } else {
//            print("nothing")
//            guard let button = minusButton else { return }
//            button.isEnabled = false
//        }
        
        productCount += 1
        if let index = cellIndex {
            delegate?.updateProductCount(index: index, count: productCount)
            updateProductCountLabel()
        }
        //test_put_draft_order ()
    }
    
    @IBAction func minusItemButtonPressed(_ sender: Any) {
        productCount -= 1
        if let index = cellIndex {
            delegate?.updateProductCount(index: index, count: productCount)
            updateProductCountLabel()
        }
        //test_put_draft_order ()
    }
    
    func updateProductCountLabel () {
        //productPriceLabel.text = String(numberOfCartItems)
        productCountLabel.text = String(productCount)
    }
    
}

// MARK: - Conform cell protocol
extension ShoppingCartCell: ShoppingCartCellProtocol {
    func configureCell(_ product: ShoppingCartModel, index: Int) {
        productImageView.downloadImageFrom(product.image, placeHolder: "lazaApp")
        productTitleLabel.text = product.title
        
        let stringPrice = String(product.price ?? 100)
        //let stringPrice = String(format: "%.1f", product.price ?? 100)
        let (priceText, symbol) = CurrencyManager.returnPriceAndSymbol(price: stringPrice)
        
//        productPriceLabel.text = "\(product.price ?? 100)  EGP"
//        productCountLabel.text = "\(product.quantity ?? 1)"
        
        productPriceLabel.text = priceText + "  " + symbol
        productCountLabel.text = "\(product.quantity ?? 1)"
        
        // set product count & available count for the product.
        productCount = product.quantity ?? 1
        availableElements = product.availableElements ?? 1
        
        print(productCount, availableElements)  // availableElements always return nil.
        self.cellIndex = index
    }
    
    
    
    //    func test_put_draft_order () {
    //        let url = "https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/draft_orders/1031372177558.json"
    //        let params = ["draft_order":["id":1031372177558,"line_items":[["variant_id":42798192099478,"quantity":8888, "sku" : "new sku",
    //                                                                       "properties": [["name":"value", "value" : "value2"]]], ["variant_id":42798187446422,"quantity":33, "sku" : "new sku2"]]]]
    //
    //        let header : HTTPHeaders = ["X-Shopify-Access-Token": "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"]
    //
    //        Alamofire.AF.request(url, method: .put, parameters: params, headers: header).response { data in
    //
    //            print("I am done")
    //        }
    //    }
    
    //        productCount += 1
    //        if let index = cellIndex {
    //            delegate?.updateProductCount(index: index, count: productCount)
    //            updateProductCountLabel()
    //        }
    
    //        if productCount > 1  {
    //            productCount -= 1
    //            if let index = cellIndex {
    //                delegate?.updateProductCount(index: index, count: productCount)
    //                updateProductCountLabel()
    //            }
    //        } else {
    //            guard let button = minusButton else { return }
    //            button.isEnabled = false
    //        }
}


