//
//  HomeViewModel.swift
//  E-Commerce-Project
//
//  Created by Abdallah on 25/10/2023.
//

import Foundation

class CategoryViewModel{
    var  bindresultToHomeViewController: ( () -> () ) = {}
//    var data : Brands?
   
    var handerDataOfHome: (() -> Void)?
    var services = NetworkServices()
    
    var getAllProducts: ProductsResponse? {
        didSet{
            if let validHander =  handerDataOfHome {
                validHander()
            }
        }
    }

   
    
    //MARK: -Get All Model Return From Api
    func getProducts() -> ProductsResponse? {
        return getAllProducts
    }
    
    
    //MARK: -CAll Request of Api
    func getDataFromApiForHome() {
        services.getDataToCategory(Handler: { (dataValue:ProductsResponse?, error: Error?) in
            print("Success")

            if let mydata = dataValue {
                self.getAllProducts = mydata
                self.bindresultToHomeViewController()

            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
    }
    //MARK: -Getting Number of Brands
func getNumberOfProducts() -> Int? {
//    print(getAllBrands?.smart_collections.count)
    print(getAllProducts?.products.count)
    return getAllProducts?.products.count
   }
    func getTitle(index: Int) -> String?{
        return getAllProducts?.products[index].title ?? "NO"

    }
    func getImage(index: Int) -> String?{
        return getAllProducts?.products[index].images[0].src
    }
    func getPrice(index: Int) -> String?{
     
        return getAllProducts?.products[index].variants[0].price
    }
}
    

