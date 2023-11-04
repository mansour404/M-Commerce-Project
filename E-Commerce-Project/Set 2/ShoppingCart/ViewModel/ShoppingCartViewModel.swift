//
//  ShoppingCartViewModel.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 28/10/2023.
//

import Foundation


class ShoppingCartViewModel {
    
    // MARK: - Variables
    private let shoppingCartService: ShoppingCartService
    
    
    // MARK: - Properties
    private let customerId = UserDefaultsHelper.shared.getCustomerId()


    var cartProductsCount: Int {
        return cartProducts.count
    }
    
    
    // MARK: - Callback
    // callback for interface
    private var cartProducts: [ShoppingCartModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadTableViewClosure?()
            }
        }
    }
    
    // MARK: - Init
    init(shoppingCartService: ShoppingCartService = ShoppingCartService()) {
        self.shoppingCartService = shoppingCartService
        
    }
    
    // MARK: - Closures
    var reloadTableViewClosure: (() -> ())?
    var updateTotalPriceClosure: ((Double,String) -> ())?
    
    
    // MARK: - Functions
    func configCell(_ cell: ShoppingCartCell, at index: Int) {
        let product = cartProducts[index]
//        print("+++++++++++++++++++++++")
//        print(product)
//        print("+++++++++++++++++++++++")
//        print(cartProducts)
//        print("+++++++++++++++++++++++")
        cell.configureCell(product, index: index)
    }
    
    // MARK: -  Configure cell for order view, the next view.
    func configureCollectionViewCell(_ cell: ProductItemCell, at index: Int) {
        let product = cartProducts[index]
        cell.configureCell(product, index: index)
    }
    
    // MARK: - Mainpulate shopping cart
    func fetchCartProducts() {
        print(customerId)
        shoppingCartService.getShoppingCartProducts(customerId: customerId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let cartProducts):
                self.cartProducts = cartProducts
                let totalPrice = cartProducts.map { ($0.price ?? 0) * Double($0.quantity ?? 0) }.reduce(0, +)
                //let priceString = String(format: "%.2f", totalPrice) + "  EGP"
                let symbol = UserDefaultsHelper.shared.getCurrencySymbol()
                DispatchQueue.main.async {
                    self.updateTotalPriceClosure?(totalPrice, symbol)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateProductCountInShoppingCart(index: Int?, count: Int?){
        if let index = index, let count = count {
            print("at")
            print("++++++++++")
            print("count", count)
            print("index", index)
            print("++++++++++")
            let cartProduct = cartProducts[index]
            updateCartProduct(cartProduct, quantity: count, customerId: customerId)
        }
        //shoppingCartService.test_put_draft_order()
    }
    
    func deleteProductFromShoppingCart(index: Int? = nil) {
        print("8888888888888")
        if let index = index {
            print("at")
            deleteCartProduct(cartProducts[index])
        }
        print("7777777777777")
    }
    
    // MARK: - Private Function
    private func deleteCartProduct(_ cartProduct: ShoppingCartModel) {
        shoppingCartService.removeProductFromCart(cartProduct: cartProduct, customerId: customerId) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print(error)
                return
            }
            self.fetchCartProducts()
        }
    }
    
    private func updateCartProduct(_ cartProduct: ShoppingCartModel, quantity: Int, customerId: Int) {
        shoppingCartService.updateProductQuantity(cart: cartProduct, quantity: quantity, customerId: customerId) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print(error)
                return
            }
            self.fetchCartProducts()
        }
    }
}
