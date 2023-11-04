//
//  FavouriteViewModel.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 25/10/2023.
//

import Foundation
import Alamofire
class FavouriteViewModel {
     private var productArray : [Product] = []
        var handerDataOfHome: (() -> Void)?
        var  bindresultToProductsViewController: ( () -> () ) = {}
    var compiltionHandler: ((_ id : Int) -> ()) = {id in }
        var services = NetworkServices()
        
        var AllUserWishList: WhishList? {
            didSet{
                if let validHander =  handerDataOfHome {
                    validHander()
                }
            }
        }
        
        //MARK: -CAll Request of Api
        func getDataFromApiForProduct() {
            print("======================")
            print("============\(UserDefaultsHelper.shared.getCustomerId())")
            print("======================")
            services.getCustomerWishList(CustomerId: UserDefaultsHelper.shared.getCustomerId(), Handler: { (dataValue:WhishList?, error: Error?) in
                
                if let mydata = dataValue {
                    self.AllUserWishList = mydata
                    print(mydata.metafields.count)
                    
                    self.getproducts()
                }else {
                    if let error = error{
                        print(error.localizedDescription)
                    }
                }
            })
         
        }
    
        
        //MARK: -Getting Number of Brands
    func getNumberOfProduct() -> Int? {
        return productArray.count
       }
        func getTitle(index: Int) -> String?{
            return  productArray[index].title
        }
    func getprice(index : Int) ->String? {
        return  productArray[index].variants?[0].price
    }
    func getImageUrl(index : Int)->String? {
        return productArray[index].images[0].src
    }
    let dispatchGroup = DispatchGroup()
    func getproducts(){
        productArray = []
        
        for i in 0..<(AllUserWishList?.metafields.count)! {
            dispatchGroup.enter()
            services.getProductById(ProductId: AllUserWishList!.metafields[i].key! , Handler: { (dataValue:MyProductcontainer?, error: Error?) in
                print("Success")
                
                if let mydata = dataValue {
                    self.productArray.append( mydata.product)
                //    self.bindresultToProductsViewController()
                    self.dispatchGroup.leave()
                }else {
                    if let error = error{
                        print(error.localizedDescription)
                    }
                }
            })
            
        }
        dispatchGroup.notify(queue: DispatchQueue.main){
            DispatchQueue.main.async {
                self.bindresultToProductsViewController()
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
