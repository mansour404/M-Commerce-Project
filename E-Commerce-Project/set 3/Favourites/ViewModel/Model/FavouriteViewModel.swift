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
        for i in 0..<(AllUserWishList?.metafields.count)! {
            services.getProductById(ProductId: AllUserWishList!.metafields[i].Key! , Handler: { (dataValue:ProductsList?, error: Error?) in
                print("Success")
                
                if let mydata = dataValue {
                    self.productArray = mydata.products
                    self.bindresultToProductsViewController()
                    
                }else {
                    if let error = error{
                        print(error.localizedDescription)
                    }
                }
            })
            
        }
    
    }
       
    
        



}
