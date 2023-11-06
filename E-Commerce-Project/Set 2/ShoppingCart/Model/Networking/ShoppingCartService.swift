//
//  ShoppingCartService.swift
//  E-Commerce-Project
//
//  Created by Mohammed Adel on 28/10/2023.
//

import Foundation
import Alamofire

class CartList {
    static var carts: [ShoppingCartModel] = []
}

class ShoppingCartService {
    //let stringUrl = "https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/draft_orders/\(customerId)/addresses/\(address_id).json"
    let headers: HTTPHeaders = [
        "X-Shopify-Access-Token": "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",
        "Content-Type": "application/json"
    ]
  
    // MARK: - Get all products from shopping cart
    func getShoppingCartProducts(customerId: Int, completion: @escaping (Result<[ShoppingCartModel], Error>) -> Void) {
        var items: [ShoppingCartModel] = [ShoppingCartModel]()
        CartList.carts = []
        let stringUrl = "https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/draft_orders.json"
        
        AF.request(stringUrl, method: .get, encoding: URLEncoding.default, headers: headers).responseDecodable(of: DraftOrdersResult.self) { response in
            switch response.result {
            case .success(let draftOrders):
                guard let draftOrders = draftOrders.draft_orders else { return }
                for draftOrder in draftOrders {
                    let check_id = draftOrder.customer?.id
                    if check_id == customerId && "rush order" == draftOrder.note {
                        print("not break")
                        let orderId = draftOrder.id
                        let variant_id = draftOrder.line_items?.first?.variant_id
                        let title = draftOrder.line_items?.first?.title
                        let price = Double(draftOrder.line_items?.first?.price ?? "1")
                        let image = draftOrder.line_items?.first?.properties?.first?.value
                        let quantity = draftOrder.line_items?.first?.quantity
                        let availableElements = Int(draftOrder.line_items?.first?.sku ?? "1")
                        //let inventory_item_id = draftOrder.line_items?.first?.variant_id.
                        
                        let cartProduct = ShoppingCartModel(title: title, quantity: quantity, price: price, image: image, draftOrderId: orderId, variantId: variant_id, availableElements: availableElements, inventory_item_id: 99)
                        items.append(cartProduct)
                        print("added")
                    } else {
                        print("not added")
                    }
                }
                CartList.carts = items
                completion(.success(items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - Add product to shopping cart
    func addProductToCartShopping(customerId: Int, variantId: Int, cart: ShoppingCartModel, completion: @escaping (Error?) -> Void) {
        let stringUrl = "https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/draft_orders.json"
        let price = cart.price ?? 0.0
        let quantity = cart.quantity ?? 1
        let title = cart.title ?? "Title"
        let image = cart.image ?? "Picture"
        let sku = String(cart.availableElements ?? 0)
        let inventoryItemId = cart.inventory_item_id
        
        print("++++++++++++++++++")
        print(inventoryItemId)
        print("++++++++++++++++++")

        let parameters: [String: Any] = [
            "draft_order": [
                "note": "rush order",
                "line_items":[
                    [
                        "id": variantId,
                        "variant_id": variantId, //Optional("{\"errors\":{\"line_items[0].variant_id\":[\"not found\"]}}")
                        "title":title,
                        "price":price,
                        "quantity":quantity,
                        "sku": sku,
                        //"fulfillment_service": image,
                        "properties": [
                            [
                                "name": "imageSrc",
                                "value": image
                            ]
                        ]
                    ] as [String : Any]
                ],
                "customer": [
                    "id":customerId
                ]
            ] as [String : Any]
        ]
        
        
        AF.request(stringUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response{ response in
            switch response.result {
            case .success(let data):
                print(String(data: data!, encoding: .utf8))
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    // MARK: - Update
    
    func updateProductQuantity(cart: ShoppingCartModel, quantity: Int, customerId: Int, completion: @escaping (Error?) -> Void) {
        guard let draftOrderId = cart.draftOrderId else { return }
        guard let variantId = cart.variantId else { return }
        let stringUrl = "https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/draft_orders/" + "\(draftOrderId).json"
        print(draftOrderId, variantId)
        
        let price = cart.price ?? 0.0
        //let quantity = cart.quantity ?? 1
        let title = cart.title ?? "Title"
        let image = cart.image ?? "Picture"
        let sku = String(cart.availableElements ?? 0)
        
        print(variantId)
        
//        let parameters = [
//            "draft_order": [
//                "id":draftOrderId,
//                "line_items": [
//                    [
//                        "variant_id":variantId,
//                        "quantity":quantity,
//                        "sku": "new sku",
//                        "properties": [
//                            [
//                                "name": "imageSrc",
//                                "value": image
//                            ]
//                        ]
//                    ] as [String : Any]
//                ]
//            ] as [String : Any]
//        ]
        
        let parameters: [String: Any] = [
            "draft_order": [
                "id": draftOrderId,
                "line_items":[
                    [
                        //"id": draftOrderId,
                        "variant_id": variantId,
                        "title":title,
                        "price":price,
                        "quantity":quantity, // USE the new quantity passed from minus or plus button.
                        "sku": sku,
                        "properties": [
                            [
                                "name": "imageSrc",
                                "value": image
                            ]
                        ]
                    ] as [String : Any]
                ],
                "customer": [
                    "id":customerId
                ]
            ] as [String : Any]
        ]
        
        // Note: if i want to has only one draft order, Pass new array of line items not the last line item.
        AF.request(stringUrl, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                print("UPPPPPPPPPPPPPPPPPPP")
                print(String(data: data!, encoding: .utf8))
                completion(nil)
            case .failure(let error):
                print("NIIIIIIIIIIIIIIIIIIIII")
                completion(error)
            }
        }
    }
    
    
    // MARK: - Remove
    func removeProductFromCart(cartProduct: ShoppingCartModel, customerId: Int, completion: @escaping (Error?) -> Void) {
        guard let draftOrderId = cartProduct.draftOrderId else { return }
        let stringUrl = "https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/draft_orders" + "/\(draftOrderId).json"
        
        AF.request(stringUrl, method: .delete, headers: headers).response { response in
            switch response.result {
            case .success(_):
                completion(nil)
            case.failure(let error):
                completion(error)
            }
        }
    }
    
}

