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
                    print("this is from get customer wishlist \(String(describing: mydata.draft_orders?.count))")
                    print("==========================================")
                    self.AllDraftOrdersZiyad = mydata
                    self.getwishlistforCustomer()
                    self.bindresultToProductsViewController()
                }else {
                    if let error = error{
                        print(error.localizedDescription)
                    }
                }
            })
         
        }
    
        
        //MARK: -Getting Number of Brands
    func getNumberOfProduct() -> Int? {
        print("==========================================")
        print("this is from getNumberOfProductwishlist \(String(describing:CustomerWishlist.count))")
        print("==========================================")
        return CustomerWishlist.count
       }
    func getTitle(index: Int) -> String?{
        return  CustomerWishlist[index].line_items?[0].title ?? "title"
    }
    func getprice(index : Int) ->String? {
        return   CustomerWishlist[index].line_items?[0].price ?? "130"
    }
    func getImageUrl(index : Int)->String? {
        return  CustomerWishlist[index].line_items?[0].properties?[0].value
    }
    func getwishlistforCustomer(){
        CustomerWishlist = []
        print("++++++++++++++++++++++++++++++++++++")
        print("\(String(describing: AllDraftOrdersZiyad?.draft_orders?.count))")
        print("++++++++++++++++++++++++++++++++++++")

        if((AllDraftOrdersZiyad?.draft_orders?.count ?? 0) > 0){
            for i in 0..<(AllDraftOrdersZiyad?.draft_orders?.count)! {
                print("\(String(describing: AllDraftOrdersZiyad?.draft_orders?.count))")
                if(UserDefaultsHelper.shared.getCustomerId() != 0){
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
        
    
       // sendwishid-> deleteProductFromFavourites -> StageDelete
    
    func sendWishId(userID : Int64 ,productId : Int) {
//        var wishId = 0
//        services.getfavouriteItem(userID: UserDefaultsHelper.shared.getCustomerId() , productId: productId, Handler: { (dataValue:WhishList?, error: Error?) in
//            print("Success")
//            if let mydata = dataValue {
//                if(mydata.metafields.isEmpty == false ){
//                    wishId = mydata.metafields[0].id!
//                    self.compiltionHandler(wishId)
//                }
//                else if (mydata.metafields[0].key == String(productId) && mydata.metafields[0].owner_id! == userID ) {
//                    self.compiltionHandler(-1)
//                }
//            }else {
//                if let error = error{
//                    print(error.localizedDescription)
//                }
//            }
//        })
        services.getCustomerWishList( Handler: { (dataValue:DraftOrdersResult?, error: Error?) in
            
            if let mydata = dataValue {
            
                self.AllDraftOrdersZiyad = mydata
                self.getwishlistforCustomer()
//                self.bindresultToProductsViewController()
                self.filterBaseOnProductId(productId: productId)
            }else {
                if let error = error{
        
                    print(error.localizedDescription)
                }
            }
        })
        
        //return wishId
    }
    
    func filterBaseOnProductId(productId : Int ){
        self.compiltionHandler(-1)
        for d in 0..<CustomerWishlist.count {
            if(CustomerWishlist[d].line_items?[0].variant_id == productId ){
                self.compiltionHandler(CustomerWishlist[d].id ?? 0)
                break
            }
        }
    }

    

}
