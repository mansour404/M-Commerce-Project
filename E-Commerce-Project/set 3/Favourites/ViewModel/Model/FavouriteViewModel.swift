//
//  FavouriteViewModel.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 25/10/2023.
//

import Foundation
import Alamofire
class FavouriteViewModel {
    
        var handerDataOfHome: (() -> Void)?
        var  bindresultToProductsViewController: ( () -> () ) = {}
    var compiltionHandler: ((_ id : Int) -> ()) = {id in }
        var services = NetworkServices()
    var CustomerWishlist : [Draft_orders] = []
    var AllDraftOrdersZiyad: DraftOrdersResult? {
            didSet{
                
                self.getwishlistforCustomer()
            }
        }
        
        //MARK: -CAll Request of Api
        func getDataFromApiForProduct() {
            print("======================")
            print("============\(UserDefaultsHelper.shared.getCustomerId())")
            print("======================")
            services.getCustomerWishList( Handler: { (dataValue:DraftOrdersResult?, error: Error?) in
                
                if let mydata = dataValue {
                    print("==========================================")
                    print(mydata.draft_orders?.count)
                    print("==========================================")
                    self.AllDraftOrdersZiyad = mydata
                    
                   
                }else {
                    if let error = error{
                        print(error.localizedDescription)
                    }
                }
            })
         
        }
    
        
        //MARK: -Getting Number of Brands
    func getNumberOfProduct() -> Int? {
        return CustomerWishlist.count
       }
    func getTitle(index: Int) -> String?{
        return  CustomerWishlist[index].line_items![0].title
    }
    func getprice(index : Int) ->String? {
        return   CustomerWishlist[index].line_items![0].price
    }
    func getImageUrl(index : Int)->String? {
        return  CustomerWishlist[index].line_items![0].sku
    }
    func getwishlistforCustomer(){
        CustomerWishlist = []
        print("\(String(describing: AllDraftOrdersZiyad?.draft_orders?.count))")
        if((AllDraftOrdersZiyad?.draft_orders?.count ?? 0) > 0){
            for i in 0..<(AllDraftOrdersZiyad?.draft_orders?.count)! {
                print("\(String(describing: AllDraftOrdersZiyad?.draft_orders?.count))")
                if(UserDefaultsHelper.shared.getCustomerId() > 0){
                    if(AllDraftOrdersZiyad?.draft_orders?[i].note == "Wishlist" ){
                        
                        let mycustomer : CustomerTwo = (AllDraftOrdersZiyad?.draft_orders?[i].customer)!
                        if(mycustomer.id == UserDefaultsHelper.shared.getCustomerId()){
                            CustomerWishlist.append(AllDraftOrdersZiyad!.draft_orders![i])
                            print("added from getwishlistforCustomer ")
                        }
                    }
                }
            }
        }

            
        }
        
    
       
    
    func sendWishId(userID : Int64 ,productId : Int) {
        var wishId = 0
        services.getfavouriteItem(userID: UserDefaultsHelper.shared.getCustomerId() , productId: productId, Handler: { (dataValue:WhishList?, error: Error?) in
            print("Success")
            if let mydata = dataValue {
                if(mydata.metafields.isEmpty == false ){
                    wishId = mydata.metafields[0].id!
                    self.compiltionHandler(wishId)
                }
                else if (mydata.metafields[0].key == String(productId) && mydata.metafields[0].owner_id! == userID ) {
                    self.compiltionHandler(-1)
                }
            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
        //return wishId
    }
    

    

}
