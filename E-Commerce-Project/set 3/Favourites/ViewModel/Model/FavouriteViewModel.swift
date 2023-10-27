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
            services.getCustomerWishList(CustomerId: 6866434621590, Handler: { (dataValue:WhishList?, error: Error?) in
                print("Success")
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
    func getproducts(){
        productArray = []
        for i in 0..<(AllUserWishList?.metafields.count)! {
        
            services.getProductById(ProductId: AllUserWishList!.metafields[i].key! , Handler: { (dataValue:MyProductcontainer?, error: Error?) in
                print("Success")
                
                if let mydata = dataValue {
                    self.productArray.append( mydata.product)
                    self.bindresultToProductsViewController()
                }else {
                    if let error = error{
                        print(error.localizedDescription)
                    }
                }
            })
            
        }
      
        
    }
       
    
    func isFavourite (userID : Int64 ,productId : Int ) ->Bool {
        var check = false
        services.getfavouriteItem(userID: 6866434621590 , productId: productId, Handler: { (dataValue:WhishList?, error: Error?) in
            print("Success")
            if let mydata = dataValue {
                if(mydata.metafields.isEmpty == false ){
                    check = false
                }
                else if (mydata.metafields[0].key == String(productId) && mydata.metafields[0].owner_id == userID ) {
                    check = true
                }
            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
        return check
    }
    
    func sendWishId(userID : Int64 ,productId : Int) ->Int{
        var wishId = 0
        services.getfavouriteItem(userID: 6866434621590 , productId: productId, Handler: { (dataValue:WhishList?, error: Error?) in
            print("Success")
            if let mydata = dataValue {
                if(mydata.metafields.isEmpty == false ){
                    wishId = mydata.metafields[0].id!
                
                }
                else if (mydata.metafields[0].key == String(productId) && mydata.metafields[0].owner_id == userID ) {
                    
                }
            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
        return wishId
    }
    


}
