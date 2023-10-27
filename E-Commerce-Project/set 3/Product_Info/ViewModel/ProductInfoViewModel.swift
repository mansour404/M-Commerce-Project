//
//  ProductInfoViewModel.swift
//  E-Commerce-Project
//
//  Created by Admin on 25/10/2023.
//

import Foundation

class ProductInfoViewModel {
    
    var id : Int64?
    var product : ProductCompleteModel?
    
    var manager = AbstractNetworkService()
    var networkManager = NetworkServices()
    var myView : ProductInfoViewController?
    func reload_my_view () {
        myView?.viewReload()
    }
    
    func numberOfOptions () -> Int{
        return product?.options?.count ?? 0
    }
    
    func optionValuesCount (for_Row row : Int) -> Int{
        return product?.options?[row].values?.count ?? 0
    }
    
    
    func optionName (row : Int, column : Int) -> String {
        return product?.options?[row].values?[column] ?? "Nil"
    }
    
    func initializeProduct () {
        manager.getData(endPoint: EndPoint.product_info(ProductID: id!), Handler: { (dataValue:AllProducts?, error: Error?) in
            print("Success")

            if let mydata = dataValue {
                self.product = mydata.product
                self.reload_my_view()
                
                //print(mydata)

            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
    }
    
    func isInFavourite() -> Bool{
        return FavouriteViewModel().isFavourite(userID: 6866434621590, productId: Int(id!))
    }
    func deleteProductFromFavourites(){
        networkManager.removefavouriteItem(userID: 6866434621590, wishId: FavouriteViewModel().sendWishId(userID: 6866434621590, productId:  Int(id!)))
    }
    
}
