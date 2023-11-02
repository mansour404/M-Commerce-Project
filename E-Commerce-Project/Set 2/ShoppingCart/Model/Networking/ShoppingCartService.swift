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
        let stringUrl = "https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/draft_orders.json"
        
        AF.request(stringUrl, method: .get, encoding: URLEncoding.default, headers: headers).responseDecodable(of: DraftOrdersResult.self) { response in
            switch response.result {
            case .success(let draftOrders):
                guard let draftOrders = draftOrders.draft_orders else { return }
                for draftOrder in draftOrders {
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
              "line_items":[
                 [
                    "id": variantId,
                    "variant_id": variantId, //Optional("{\"errors\":{\"line_items[0].variant_id\":[\"not found\"]}}")
                    "title":title,
                    "price":price,
                    "quantity":quantity,
                    "sku": sku,
                    "fulfillment_service": image,
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
    func updateProductQuantity(cartProduct: ShoppingCartModel, quantity: Int, customerId: Int, completion:  @escaping (Result<[DraftOrdersResult], Error>) -> Void) {
        guard let draftOrderId = cartProduct.draftOrderId else { return }
        guard let variantId = cartProduct.variantId else { return }
        let stringUrl = "https://ios-q1-new-capital-admin2-2023.myshopify.com/admin/api/2023-10/draft_orders" + "/\(draftOrderId).json"
        
        let parameters: [String: Any] = [
            "draft_order": [ "line_items": [
                [ "variant_id": variantId, "quantity": quantity, "properties": [
                    ["name": "imageSrc", "value": cartProduct.image]
                ] ] as [String : Any] ]
                           ]
        ]
        
        // Note: Pass new array of line items not the last line item.
        //let parameters: [String: Any] = Hopa()
        AF.request(stringUrl, method: .put, parameters: parameters, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                print(data)
                //completion(nil)
//                do {
//                    let result = try JSONDecoder().decode(DraftOrdersResult.self, from: data)
//                    completion(.success(<#T##[DraftOrdersResult]#>))
//                } catch {
//                    print("Error: Trying to convert JSON data to string")
//                    return
//                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
//    private func Hopa() -> [String: Any] {
//        var arr = ShoppingCartList.items
//        if arr.isEmpty {
//            let lineItem = Line_items(price: "88.9", quantity: 22, title: "Dummy", variant_id: nil, vendor: nil, sku: "")
//            arr.append(lineItem)
//        }
//        let draftOrder = Draft_orders(id: nil, note: nil, line_items: arr, customer: nil)
//        let resoponse = DraftOrdersResult(draft_orders: [draftOrder])
//        let params = JsonEncoderHelper.convertObjectToJson(object: resoponse)!
//        return params
//    }
    
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
