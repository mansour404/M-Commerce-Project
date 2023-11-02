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
    var updateTotalPriceClosure: ((String) -> ())?
    
    
    // MARK: - Functions
    func configCell(_ cell: ShoppingCartCell, at index: Int) {
        let product = cartProducts[index]
        cell.configureCell(product, index: index)
    }
    
    func configureCollectionViewCell(_ cell: ProductItemCell, at index: Int) {
        let product = cartProducts[index]
        cell.configureCell(product, index: index)
    }
    
    func fetchCartProducts() {
        shoppingCartService.getShoppingCartProducts(customerId: customerId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let cartProducts):
                self.cartProducts = cartProducts
                let totalPrice = cartProducts.map { ($0.price ?? 0) * Double($0.quantity ?? 0) }.reduce(0, +)
                let priceString = String(format: "%.2f", totalPrice) + "  EGP"
                DispatchQueue.main.async {
                    self.updateTotalPriceClosure?(priceString)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateProductCount(index: Int, count: Int){
        let variantId = index
        if let cartProduct = cartProducts.first(where: { $0.variantId == variantId }) {
            print("\(count)")
            shoppingCartService.updateProductQuantity(cartProduct: cartProduct, quantity: count, customerId: customerId) { [weak self] error in
                guard let self = self else { return }
                self.fetchCartProducts()
            }
        }
    }
    
    func deleteProductFromShoppingCart(forCellID id: Int? = nil, at index: Int? = nil) {
        if let id = id {
            let variantId = id
            if let cartProduct = cartProducts.first(where: { $0.variantId == variantId }) {
                deleteCartProduct(cartProduct)
            }
        } else if let index = index {
            deleteCartProduct(cartProducts[index])
        }
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
    
    
}
