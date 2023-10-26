//
//  ProductViewModel.swift
//  E-Commerce-Project
//
//  Created by Ziyad Qassem on 25/10/2023.
//

import Foundation
class ProductViewModel {
    var handerDataOfHome: (() -> Void)?
    var  bindresultToProductsViewController: ( () -> () ) = {}
  
    var services = NetworkServices()
    
    var AllBrandProducts: ProductsResponse? {
        didSet{
            if let validHander =  handerDataOfHome {
                validHander()
            }
        }
    }
    
    //MARK: -CAll Request of Api
    func getDataFromApiForProduct() {
        services.getAllProductsForBrandData(BrandId: HomeViewModel.selectedBrandID ?? 303787573398, Handler: { (dataValue:ProductsResponse?, error: Error?) in
            print("Success")

            if let mydata = dataValue {
                self.AllBrandProducts = mydata
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
//    print(getAllBrands?.smart_collections.count)
   
    return AllBrandProducts?.products.count
   }
    func getTitle(index: Int) -> String?{
        return  AllBrandProducts?.products[index].title
 
    } 
    func getid(index: Int) -> String{
        return  AllBrandProducts?.products[index].images[0].src ?? "none"
 
    }
    func getProductID (index : Int) -> Int64{
            return AllBrandProducts?.products[index].id ?? 0
        }
   
//    func getImage(index: Int) -> String?{
//        return getAllBrands?.smart_collections[index].image.src
//
//    }
}
    


