//
//  PaymentViewModel.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 31/10/2023.
//

import Foundation


class PaymentViewModel {
    // MARK: - Variables
    private let paymentNetworkService: PaymentService
    private let draftOrderNetworkService: ShoppingCartService
    private let shippingAddress: Shipping_address?
    
    
    // MARK: - Properties
//    private let customerId = UserDefaultsHelper.shared.getCustomerId()
//    var cartProductsCount: Int {
//        return cartProducts.count
//    }
    
    
    // MARK: - Init
    init(shippingAddress: Shipping_address? = nil) {
        self.paymentNetworkService = PaymentService()
        self.draftOrderNetworkService = ShoppingCartService()
        self.shippingAddress = shippingAddress
    }
    
    // MARK: - Post Order
    func postOrder() {
        let customerId = UserDefaultsHelper.shared.getCustomerId()
        // TODO: - let shipingAddress = get Address by id from api.
        let items = CartList.carts
        print(items)
        var line_items: [Line_items] = []
        for item in items {
            let newItem = Line_items(price: String(item.price ?? 1.00), quantity: item.quantity, title: item.title, variant_id: nil, vendor: nil, sku: nil, properties: nil)
            line_items.append(newItem)
        }
        
        // TODO: - Don't forget to set shipping address. // done.
        // TODO: - Don't forget total_discounts //
        let currency = UserDefaultsHelper.shared.getCurrencySymbol()
        let phone = "+2" + (shippingAddress?.phone ?? "0109999999")
        let order = OrderNewModel(total_tax: "0", currency: currency, phone: phone, total_discounts: "0", user_id: String(customerId), line_items: line_items, shipping_address: shippingAddress)
        
        print("*************")
        print(order)
        print("*************")

        // Helper methods to creat paramters depend on lineItems count.
        let orderResult = OrdersResultNewModel(order: order)
        let parameters = JsonEncoderHelper.convertObjectToJson(object: orderResult) ?? [:]
        
        paymentNetworkService.postOrder(parameters: parameters) { [weak self] error in
            guard let self = self else { return }
            if error != nil {
                print(error)
            } else {
                print("SIIIIIIIIIIIIII add new order")
                self.updateInventoryLevelForProduct()
                //self?.emptyShoppingCartDraftOrder()
            }
        }
    }
    
    // MARK: - Empty Shopping Cart
    private func emptyShoppingCartDraftOrder() {
        let customerId = UserDefaultsHelper.shared.getCustomerId()
        for cart in CartList.carts {
            draftOrderNetworkService.removeProductFromCart(cartProduct: cart, customerId: customerId) { error in
                if error != nil {
                    print(error)
                    print("Sad!!")
                } else { // succeed
                    print("Empty Shopping Cart Successfully")
                    CartList.carts = []
                }
            }
        }
    }
    
    // MARK: - update Inventory Level
    func updateInventoryLevelForProduct() {
        let items = CartList.carts
        for item in items {
            item.inventory_item_id
            guard let inventoryItemId = item.inventory_item_id, let count = item.quantity else {//
                print("inventory_item_id", item.inventory_item_id)
                print("quantity", item.quantity)
                print("found nil before update inventory item.")
                return
            }
            print("******************")
            print(inventoryItemId, count)
            // 44895611682966 11 For bag
            print("******************")
            
            //TODO: - Update inventory level for product"
            paymentNetworkService.postInventoryLevelForProduct(inventory_item_id: inventoryItemId, available_adjustment: (count * -1)) { [weak self] error in
                guard let self = self else { return }
                if error != nil {
                    print(error)
                    print("Not udated")
                } else { // succeed
                    print("Inventory Level Upated Successfully")
                    self.emptyShoppingCartDraftOrder()
                    //CartList.carts = []
                }
            }
        }
    }
    
}

/*
 {
     "order": {
         "line_items": [
             {
                 "title": "Big Brown Bear Boots",
                 "price": 150.00,
                 "quantity": 2
             },
             {
                 "title": "Big Brown Bear Boots",
                 "price": 100.00,
                 "quantity": 3
             },
             {
                 "title": "Big Brown Bear Boots",
                 "price": 300.00,
                 "quantity": 1
             }
         ],
         // "transactions": [
         //     {
         //         "kind": "sale",
         //         "status": "success",
         //         "amount": 900.00
         //     }
         // ],
         "total_tax": 0,
         "currency": "EUR",
         "phone": "+201063464493"
         // "po_number": "01063464493",
         // "location_id": 8159536349334,
         // "shipping_address": {
         //     "address1": "jjjj",
         //     "city": "eewe",
         //     "first_name": "trtrtr",
         //     "last_name": "uuuuioo",
         //     "phone": "999",
         //     "country": "Egypt",
         //     "name": "khater kahater4",
         //     "country_name": "Egypt"
         // }
     }
 }
 */
