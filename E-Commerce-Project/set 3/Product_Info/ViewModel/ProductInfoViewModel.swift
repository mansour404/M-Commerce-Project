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
    
    var obj = FavouriteViewModel()
    
    var isInFavourites : Bool = false
    var  bindresultToProductsViewController: ( (_ colored : Bool) -> () ) = {colored in}
    
   
    
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
    
    func StageDelete(){
     
        obj.compiltionHandler = { id in
            if id != -1 {
                self.deleteProductFromFavourites(wishId: id)
            }
            
        }
        
          
    }
    
        func deleteProductFromFavourites(wishId : Int){
            networkManager.removefavouriteItem(userID: 6866434621590, wishId: wishId ,Handler: {
            self.bindresultToProductsViewController(false)
        })
        
    }
    func createFavourite(){
        networkManager.addFavouriteItem(userID: 6866434621590, productId: Int(id!), productName: (product?.title)!, Handler:{
            self.bindresultToProductsViewController(true)
        })
    }
    
    func  setControllerFavourite(){
        networkManager.getfavouriteItem(userID: 6866434621590 , productId: Int(id!), Handler: { (dataValue:WhishList?, error: Error?) in
            print("Success")
            if let mydata = dataValue {
                print(mydata.metafields)
                print(mydata.metafields.isEmpty)
                
                if(mydata.metafields.isEmpty == true ){
                    self.bindresultToProductsViewController(false)
                    
                }
                else  {
                    self.bindresultToProductsViewController(true)
                  
                }
                print("yousof is right")
            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
       print("ziyad is wrong")
        
    }
    //MARK: - Fetching Data From Api to chech if in favourite
    
}
